part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserEvent extends UserEvent {
  final String userId;
  const GetUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

final class AddUserDataEvent extends UserEvent {
  final UserModel user;
  const AddUserDataEvent({required this.user});

  @override
  List<Object> get props => [user];
}

final class UpdateUserDataEvent extends UserEvent {
  final UserModel user;
  const UpdateUserDataEvent({required this.user});

  @override
  List<Object> get props => [user];
}
final class DeleteUserEvent extends UserEvent {
  final String userId;
  const DeleteUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
final class ClearUserEvent extends UserEvent {}
