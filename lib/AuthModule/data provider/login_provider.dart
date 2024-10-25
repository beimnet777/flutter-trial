import 'package:dio/dio.dart';

class LoginProvider {
  final Dio dio;

  LoginProvider() : dio = Dio();

  Future<Response> loging(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    try {
      print("*************");
      print(data);

      final response = await dio.post(
        "http://localhost:8000/api/v1/user/auth/token/",
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(response.statusCode);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
