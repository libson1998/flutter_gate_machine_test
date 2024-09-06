import 'package:flutter/material.dart';
import 'package:flutter_gate/data/service/storage_service.dart';
import 'package:flutter_gate/main.dart';
import 'package:flutter_gate/notification/local_notification.dart';
import 'package:flutter_gate/ui/home/home_screen.dart';
import 'package:flutter_gate/ui/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxString otpVerificationId = ''.obs;
  RxString mobile = "".obs;
  RxString otp = "".obs;
  final storageService = StorageService();

  var isPhoneAuthenticated = false.obs;
  var isOtpSent = false.obs;
  RxBool isLoggedIn = false.obs;
  var user = Rxn<User>();
  RxBool isLoading = false.obs;
  var isPhoneNumberEntry = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    isLoggedIn.value = storageService.read<bool>('isLoggedIn') ?? false;
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      user.value = userCredential.user;
      await storageService.write('name', user.value!.displayName);
      await storageService.write('email', user.value!.email);
      await storageService.write('number', user.value!.phoneNumber);
      await storageService.write('photo', user.value!.photoURL);

      if (user.value != null && !isPhoneAuthenticated.value) {
        isPhoneNumberEntry.value = true;
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign-in failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      await storageService.clearStorage();

      user.value = null;
      isLoggedIn.value = false;
      isPhoneAuthenticated.value = false;

      Get.offAll(() => LoginScreen());

      Get.snackbar('Success', 'You have been logged out successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    isLoading.value = true;
    isPhoneNumberEntry.value = false;

    try {
      String formattedPhoneNumber = phoneNumber.trim().startsWith('+')
          ? phoneNumber.trim()
          : '+91${phoneNumber.trim()}';

      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          isPhoneAuthenticated.value = true;
          isOtpSent.value = false;
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Verification Failed', e.message!);
        },
        codeSent: (String verificationId, int? resendToken) {
          otpVerificationId.value = verificationId;
          isOtpSent.value = true;
          String simulatedOTP = "123456";

          LocalNotificationData.showBigTextNotification(
            title: "OTP Sent",
            body: "Please verify $simulatedOTP is your OTP.",
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar('Error', 'Error verifying phone number: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithOTP(String smsCode) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otpVerificationId.value,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      isPhoneAuthenticated.value = true;
      isOtpSent.value = false;
      Get.snackbar('Success', 'Phone number verified successfully.');
      await storageService.write('isLoggedIn', true);
      Get.to(HomeScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
