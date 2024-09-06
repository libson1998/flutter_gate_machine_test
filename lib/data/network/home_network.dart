import 'package:flutter_gate/data/service/api_service.dart';
import 'package:flutter_gate/models/GetProductsResponse.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:developer' as dev;

class HomeNetwork {
  static Future<GetProductsResponse?> homeFeeds() async {
    GetProductsResponse response = GetProductsResponse();

    try {
      ApiService apiService = ApiService(dio.Dio());
      response = await apiService.getHomeFeeds();
      return response;
    } catch (e) {
      dev.log('CAUGHT PROFILE_PAGE_DETAILS_RESPONSE', error: e);
    }
    return null;
  }
}
