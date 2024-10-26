import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'datacollector_state.dart';
import 'datacollector_event.dart';
import '../../repository/datacollector_repo.dart';
import '../../data provider/datacollector_provider.dart';

final ProfileProvider profileProvider = ProfileProvider();
final ProfileRepository profileRepo = ProfileRepository(profileProvider);

class ProfileBloc extends Bloc<DataCollectorEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<CreateProfile>(_onCreateProfile);
    on<GetUserInfo>(_onGetUserInfo);
    on<UpdateProfile>(_onUpdateProfile);
    on<DeleteProfile>(_onDeleteProfile);
  }

  void _onCreateProfile(CreateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileCreating());
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      print(event.data);
      final response = await profileRepo.createProfile(event.data,
          profileImage: event.profileImage);

      final userId = response.data['user']['id'];
      final profileId = response.data['id'];
      await _preferences.setString("user_id", userId);
      await _preferences.setString("profile_id", profileId);

      emit(ProfileCreated("Profile created successfully!"));
    } catch (error) {
      emit(ProfileCreationFailed(error.toString().split(':')[1]));
    }
  }

  void _onGetUserInfo(GetUserInfo event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final profile = await profileRepo.getUserInfo(event.userId);
      emit(ProfileLoaded(profile));
    } catch (error) {
      emit(ProfileLoadingFailed("Failed to load user profile."));
    }
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());

    try {
      final response = await profileRepo.updateProfile(event.userId, event.data,
          files: event.files);
      if (response == 200) {
        emit(ProfileUpdated("Profile updated successfully!"));
      } else {
        emit(ProfileUpdateFailed("Failed to update profile."));
      }
    } catch (error) {
      emit(ProfileUpdateFailed("Failed to update profile."));
    }
  }

  void _onDeleteProfile(DeleteProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileDeleting());

    final response = await profileRepo.deleteProfile(event.userId);
    if (response == 200) {
      emit(ProfileDeleted("Profile deleted successfully!"));
    } else {
      emit(ProfileDeletionFailed("Failed to delete profile."));
    }
  }
}
