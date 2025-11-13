import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/auth_bloc/auth_bloc.dart';
import 'package:my_parking_app/logic/get_booking_slot_bloc/get_booking_slot_bloc.dart';
import 'package:my_parking_app/logic/user_bloc/user_bloc.dart';
import 'package:my_parking_app/logic/parking_area_bloc/parking_area_bloc.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
import 'package:my_parking_app/logic/parking_booking_bloc/parking_booking_bloc.dart';
import 'package:my_parking_app/presentation/screens/auth_screen.dart';
import 'package:my_parking_app/presentation/screens/navigation_screen.dart';

import 'package:my_parking_app/services/auth_service.dart';
import 'package:my_parking_app/services/parking_service.dart';
import 'package:my_parking_app/services/user_service.dart';
import 'package:my_parking_app/utils/toast_utils.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authService: AuthService(), userService: UserService())
                ..add(AppStarted()),
        ),
        BlocProvider<UserBloc>(create: (context) => UserBloc(UserService())),
        BlocProvider<ParkingBloc>(
          create: (context) => ParkingBloc(parkingService: ParkingService()),
        ),
        BlocProvider<ParkingAreaBloc>(create: (context) => ParkingAreaBloc()),
        BlocProvider<ParkingBookingBloc>(
          create: (context) => ParkingBookingBloc(
            authService: AuthService(),
            parkingService: ParkingService(),
          ),
        ),
        BlocProvider<GetBookingSlotBloc>(
          create: (context) => GetBookingSlotBloc(
            parkingService: ParkingService(),
            authService: AuthService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking App',
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastUtils.showError(context, state.message);
            } else if (state is AuthAuthenticated) {
              ////print("User authenticated: ${state.userId}");
              context.read<UserBloc>().add(GetUserEvent(userId: state.userId));
            }
          },
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return NavigationScreen();
            } else {
              return AuthScreen();
            }
          },
        ),

        theme: AppTheme.theme,
        // routes: {
        //   RootScreen.routeName: (context) => const RootScreen(),
        //   MapScreen.routeName: (context) => const MapScreen(),
        // },
        // initialRoute: '/',
      ),
    );
  }
}
