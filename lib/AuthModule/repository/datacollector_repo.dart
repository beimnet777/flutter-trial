import 'dart:io';
import 'package:dio/dio.dart';

import '../data provider/datacollector_provider.dart';

class ProfileRepository {
  final ProfileProvider provider;

  ProfileRepository(this.provider);

  // Create profile
  Future<Response> createProfile(Map<String, dynamic> data, {File? profileImage}) {
    return provider.createProfile(data, profileImage: profileImage);
  }

  // Read user profile info
  Future<Map<String, dynamic>> getUserInfo(String userId) {
    return provider.getUserInfo(userId);
  }

  // Update user profile
  Future<int> updateProfile(String userId, Map<String, dynamic> data,
      {Map<String, File>? files}) {
    return provider.updateProfile(userId, data, files: files);
  }

  // Delete user profile
  Future<int> deleteProfile(String userId) {
    return provider.deleteProfile(userId);
  }
}
