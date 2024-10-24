abstract class ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileCreating extends ProfileState {}

class ProfileCreated extends ProfileState {
  final String message;

  ProfileCreated(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileCreationFailed extends ProfileState {
  final String error;

  ProfileCreationFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profile;

  ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileLoadingFailed extends ProfileState {
  final String error;

  ProfileLoadingFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String message;

  ProfileUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateFailed extends ProfileState {
  final String error;

  ProfileUpdateFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfileDeleting extends ProfileState {}

class ProfileDeleted extends ProfileState {
  final String message;

  ProfileDeleted(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileDeletionFailed extends ProfileState {
  final String error;

  ProfileDeletionFailed(this.error);

  @override
  List<Object?> get props => [error];
}
