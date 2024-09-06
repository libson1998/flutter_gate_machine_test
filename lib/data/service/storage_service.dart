import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  // Save a value to storage
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  // Read a value from storage
  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  // Remove a value from storage
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  // Clear all stored values
  Future<void> clearStorage() async {
    await _box.erase();
  }

  // Check if a key exists
  bool hasData(String key) {
    return _box.hasData(key);
  }
}
