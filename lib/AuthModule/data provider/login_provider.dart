import 'package:dio/dio.dart';

class LoginProvider {
  final Dio dio;

  LoginProvider()
      : dio = Dio(BaseOptions(
          baseUrl: 'http://localhost:8000/api/v1/user/auth/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  Future<Response> loging(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "token/",
        data: data,
      );
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw Exception("Incorrect Username or Password");
      }
      throw Exception("Something went wrong");
    }
  }
}
