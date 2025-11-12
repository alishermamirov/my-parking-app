import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/user_bloc/user_bloc.dart';
import '../screens/profile_screen.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            Text(
              "Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text("Email"),
          ],
        );
      },
    );
  }
}
