import 'package:dio/dio.dart';

class LoginProvider {
  final Dio dio;

  LoginProvider() : dio = Dio();

  Future loging(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    try {
      print("*************");
      print(data);

      final response = await dio.post(
        "http://54.160.180.69/api/v1/user/auth/token",
        data: formData,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      return e.response?.statusCode ?? 500;
    }
  }
}
