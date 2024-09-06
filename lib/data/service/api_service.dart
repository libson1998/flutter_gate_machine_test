
import 'package:dio/dio.dart';
import 'package:flutter_gate/models/GetProductsResponse.dart';
import 'package:retrofit/retrofit.dart';
import '../../utils/constants.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl) //live link

abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl, String? token}) {
    dio.options = BaseOptions(
        receiveTimeout: const Duration(milliseconds: 60000),
        connectTimeout: const Duration(milliseconds: 60000),
        headers: {
          'Authorization': 'Bearer $token',
        });
    return _ApiService(dio, baseUrl: baseUrl);
  }


  @GET('18e8dae4-f39d-46bc-9cf6-9f8b97c32f9c')
  Future<GetProductsResponse> getHomeFeeds();
}
