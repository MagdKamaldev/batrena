import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "http://192.168.50.208:3006/api/",
          receiveDataWhenStatusError: true,
          headers: {
            "Content-Type":"application/json",
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? jwt,
  }) async {
    dio!.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
      String? jwt,
  }) async {
    dio!.options.headers = {
      
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? jwt,
  }) async {
    dio!.options.headers = {      
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

   static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? jwt,
  }) async {
    dio!.options.headers ={
      
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };

    return dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
