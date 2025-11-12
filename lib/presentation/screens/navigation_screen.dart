import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
import 'package:my_parking_app/presentation/screens/booking_slots_screen.dart';
import 'package:my_parking_app/presentation/screens/favorites_screen.dart';
import 'package:my_parking_app/presentation/screens/home_screen.dart';
import 'package:my_parking_app/presentation/screens/profile_screen.dart';

import '../../theme/app_theme.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final _pages = const [
    HomeScreen(),
    FavoritesScreen(),
    BookingSlotsScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<ParkingBloc>(context).add(GetParkingEvent());
    });

    print("booking slots screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.favorite, 'label': 'Favorites'},
      {'icon': Icons.calendar_month, 'label': 'Bookings'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final item = items[i];
          final selected = i == _currentIndex;
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: selected ? 18 : 12,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppTheme.primaryGreen.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: selected
                        ? AppTheme.primaryGreen
                        : Colors.grey.shade600,
                    size: 18,
                  ),
                  if (selected) ...[
                    const SizedBox(width: 8),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
