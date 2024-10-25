import 'dart:io';

abstract class DataCollectorEvent {
  @override
  List<Object?> get props => [];
}

class CreateProfile extends DataCollectorEvent {
  final Map<String, dynamic> data;
  final File? profileImage;

  CreateProfile(this.data, {this.profileImage});

  @override
  List<Object?> get props => [data, profileImage];
}

class GetUserInfo extends DataCollectorEvent {
  final String userId;

  GetUserInfo(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateProfile extends DataCollectorEvent {
  final String userId;
  final Map<String, dynamic> data;
  final Map<String, File>? files;

  UpdateProfile(this.userId, this.data, {this.files});

  @override
  List<Object?> get props => [userId, data, files];
}

class DeleteProfile extends DataCollectorEvent {
  final String userId;

  DeleteProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}
