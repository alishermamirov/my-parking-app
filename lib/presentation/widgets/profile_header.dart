// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../logic/user_bloc/user_bloc.dart';
import '../screens/profile_screen.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            Text(
              state is UserLoaded ? state.user.userName : "Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(state is UserLoaded ? state.user.email : "Email"),
          ],
        );
      },
    );
  }
}
