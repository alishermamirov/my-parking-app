import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
import 'package:my_parking_app/presentation/screens/navigation_screen.dart';

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
    return BlocProvider(
      create: (context) => ParkingBloc()..add(GetParkingEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking App',
        home: NavigationScreen(),
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
