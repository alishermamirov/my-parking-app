// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/get_booking_slot_bloc/get_booking_slot_bloc.dart';
import 'package:my_parking_app/logic/parking_booking_bloc/parking_booking_bloc.dart';

import 'package:my_parking_app/models/booking_model.dart';
import 'package:my_parking_app/presentation/widgets/parking_timer.dart';

class BookingTileItem extends StatelessWidget {
  final BookingModel data;
  const BookingTileItem({Key? key, required this.data}) : super(key: key);

  DateTime? convertToDatetime() {
    if (data.timestamp == null) {
      return null;
    } else {
      return DateTime.parse(data.timestamp!);
    }
  }

  void showDeletingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("O'chirmoqchimisiz"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                context.read<ParkingBookingBloc>().add(
                  CancelSlotEvent(booking: data),
                );
                await Future.delayed(Duration(seconds: 1));
                context.read<GetBookingSlotBloc>().add(
                  GetParkingBookingDataEvent(),
                );
                Navigator.of(context).pop();
              },
              child: Text("O'chirish"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Bekor qilish"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(data.timestamp);
    // print("build booking tile");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.parkingModel!.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Joy: ${data.slotName}"),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/images/image.png",
                        height: 160,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: ActionSlider.standard(
              //     child: const Text('Men keldim'),
              //     action: (controller) async {

              //       // controller.loading(); //starts loading animation
              //       // await Future.delayed(const Duration(seconds: 3));
              //       // controller.success(); //starts success animation
              //     },
              //   ),
              // ),
              // SlideCountdown(
              //   countUp: true,
              //   duration: Duration,
              //   countUpAtDuration: true,
              // ),
              SizedBox(height: 16),
              convertToDatetime() != null
                  ? ParkingTimer(date: convertToDatetime()!)
                  : SizedBox(),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                showDeletingDialog(context);
              },
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
