import 'dart:io';
import 'package:dio/dio.dart';

class ProfileProvider {
  final Dio dio;

  ProfileProvider()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://your-api-url.com/data-collectors/',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ),
        );

  // Create a new profile
  Future<int> createProfile(Map<String, dynamic> data, {File? profileImage}) async {
    try {
      FormData formData = FormData.fromMap(data);

      if (profileImage != null) {
        final imageFile = await MultipartFile.fromFile(profileImage.path);
        formData.files.add(MapEntry('profile_image', imageFile));
      }

      final response = await dio.post('create/', data: formData);
      return response.statusCode ?? 500;
    } on DioError catch (e) {
      print('Error creating profile: ${e.message}');
      return e.response?.statusCode ?? 500;
    }
  }

  // Read user profile info
  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    try {
      final response = await dio.get('me/$userId/');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load user info');
      }
    } on DioError catch (e) {
      print('Error fetching user info: ${e.message}');
      throw Exception(e.response?.data ?? 'Unknown error');
    }
  }

  // Update user profile
  Future<int> updateProfile(String userId, Map<String, dynamic> data, {File? profileImage}) async {
    try {
      FormData formData = FormData.fromMap(data);

      if (profileImage != null) {
        final imageFile = await MultipartFile.fromFile(profileImage.path);
        formData.files.add(MapEntry('profile_image', imageFile));
      }

      final response = await dio.put('update/$userId/', data: formData);
      return response.statusCode ?? 500;
    } on DioError catch (e) {
      print('Error updating profile: ${e.message}');
      return e.response?.statusCode ?? 500;
    }
  }

  // Delete user profile
  Future<int> deleteProfile(String userId) async {
    try {
      final response = await dio.delete('delete/$userId/');
      return response.statusCode ?? 500;
    } on DioError catch (e) {
      print('Error deleting profile: ${e.message}');
      return e.response?.statusCode ?? 500;
    }
  }
}
