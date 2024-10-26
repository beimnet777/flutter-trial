import 'dart:io';
import 'package:dio/dio.dart';

class ProfileProvider {
  final Dio dio;

  ProfileProvider()
      : dio = Dio(BaseOptions(
          baseUrl: 'http://54.162.136.11/api/v1/user/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  // Create a new profile
  Future<Response> createProfile(Map<String, dynamic> data,
      {File? profileImage}) async {
    try {
      final response = await dio.post('data-collector-profiles/', data: data);
      if (response.statusCode == 200) {
        print(response.data);
        return response;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print('********************************');
      print('Error creating profile: ${e}');
      print('Status code: ${e.response}');
      print('Response data: ${e.response?.data}');
      print('Request path: ${e.requestOptions.uri}');
      print('Request headers: ${e.requestOptions.headers}');
      print('Request data: ${e.requestOptions.data}');
      throw Exception(e.message);
    }
  }

  // Read user profile info
  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    try {
      final response = await dio.get('data-collector-profiles//$userId/');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load user info');
      }
    } on DioException catch (e) {
      print('Error fetching user info: ${e.message}');
      throw Exception(e.response?.data ?? 'Unknown error');
    }
  }

  // Update user profile
  Future<int> updateProfile(String userId, Map<String, dynamic> data,
      {Map<String, File>? files}) async {
    try {
      FormData formData = FormData.fromMap(data);
      files!.forEach((key, value) async {
        final imageFile = await MultipartFile.fromFile(value.path);
        formData.files.add(MapEntry(key, imageFile));
      });

      final response =
          await dio.patch('data-collector-profiles/$userId/', data: formData);
      return response.statusCode ?? 500;
    } on DioException catch (e) {
      print('Error updating profile: ${e.message}');
      return e.response?.statusCode ?? 500;
    }
  }

  // Delete user profile
  Future<int> deleteProfile(String userId) async {
    try {
      final response = await dio.delete('data-collector-profiles/$userId//');
      return response.statusCode ?? 500;
    } on DioException catch (e) {
      print('Error deleting profile: ${e.message}');
      return e.response?.statusCode ?? 500;
    }
  }
}
