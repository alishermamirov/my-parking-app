// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/user_bloc/user_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        print(state);
        final isLoading = state is UserLoading;
        return Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state is UserLoaded ? state.user.userName : "Welcome",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(10),
                child: const Icon(Icons.notifications_none),
              ),
            ],
          ),
        );
      },
    );
  }
}
