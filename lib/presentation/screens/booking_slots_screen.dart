import 'package:flutter/material.dart';
import 'package:my_parking_app/presentation/widgets/booking_tile_item.dart';

class BookingSlotsScreen extends StatelessWidget {
  const BookingSlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 244),

      appBar: AppBar(title: Text("Booking screen")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [BookingTileItem()]),
      ),
    );
  }
}
