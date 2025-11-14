import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/get_booking_slot_bloc/get_booking_slot_bloc.dart';
import 'package:my_parking_app/presentation/screens/navigation_screen.dart';
import 'package:my_parking_app/presentation/widgets/booking_tile_item.dart';

class BookingSlotsScreen extends StatefulWidget {
  const BookingSlotsScreen({super.key});

  static const routeName = "/booking";
  @override
  State<BookingSlotsScreen> createState() => _BookingSlotsScreenState();
}

class _BookingSlotsScreenState extends State<BookingSlotsScreen> {
  void getBookingData() {
    context.read<GetBookingSlotBloc>().add(GetParkingBookingDataEvent());
  }

  @override
  void initState() {
    super.initState();
    print("init");
    getBookingData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, NavigationScreen.routeName);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 244),

        appBar: AppBar(title: Text("Booking screen")),
        body: RefreshIndicator(
          onRefresh: () async {
            getBookingData();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<GetBookingSlotBloc, GetBookingSlotState>(
              builder: (context, state) {
                print(state);
                //print(state);
                if (state is GetBookingSlotLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetBookingSlotError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is GetBookingSlotSuccess) {
                  final bookings = state.bookings;
                  //print(bookings);
                  if (bookings.isEmpty) {
                    return Center(child: Text("No bookings found."));
                  }
                  return ListView.separated(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return BookingTileItem(data: booking);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
