// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:my_parking_app/services/user_service.dart';

import '../../models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUserEvent);
    // on<AddUserDataEvent>(_saveUserData);
    on<UpdateUserDataEvent>(_updateUserData);
    on<DeleteUserEvent>(_deleteUserData);
  }
  String userId = '';

  Future<void> _onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await userService.getUserData(userId);
      // await Future.delayed(Duration(seconds: 1));
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(const UserError(message: "User not found"));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  // Future<void> _saveUserData(
  //   AddUserDataEvent event,
  //   Emitter<UserState> emit,
  // ) async {
  //   try {
  //     await userService.saveUserData(event.user);
  //   } catch (e) {
  //     emit(UserError(message: e.toString()));
  //   }
  // }

  Future<void> _updateUserData(
    UpdateUserDataEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userService.updateUserData(event.user);
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> _deleteUserData(
    DeleteUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userService.deleteUserData(event.userId);
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
