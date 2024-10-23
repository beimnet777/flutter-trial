import 'package:bloc/bloc.dart';
import 'datacollector_state.dart';
import 'datacollector_event.dart';
import './../repository/datacollector_repo.dart';
import './../data provider/datacollector_provider.dart';

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

    print(event.data);
    final response = await profileRepo.createProfile(event.data,
        profileImage: event.profileImage);
    if (response == 200) {
      emit(ProfileCreated("Profile created successfully!"));
    } else {
      emit(ProfileCreated("Failed to create profile."));
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

    final response = await profileRepo.updateProfile(event.userId, event.data,
        profileImage: event.profileImage);
    if (response == 200) {
      emit(ProfileUpdated("Profile updated successfully!"));
    } else {
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
