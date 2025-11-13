import 'package:action_slider/action_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/parking_area_bloc/parking_area_bloc.dart';
import 'package:my_parking_app/logic/parking_booking_bloc/parking_booking_bloc.dart';
import 'package:my_parking_app/models/booking_model.dart';
import 'package:my_parking_app/models/parking_model.dart';
import 'package:my_parking_app/models/parking_slot_model.dart';
import 'package:my_parking_app/presentation/screens/booking_slots_screen.dart';
import 'package:my_parking_app/utils/toast_utils.dart';

class ParkingSlotsScreen extends StatefulWidget {
  final ParkingModel parking;
  const ParkingSlotsScreen({super.key, required this.parking});

  @override
  State<ParkingSlotsScreen> createState() => _ParkingSlotsScreenState();
}

class _ParkingSlotsScreenState extends State<ParkingSlotsScreen> {
  String selectedSlotId = "";
  ParkingSlotModel? selectedSlot;
  int selectedindex = -1;
  Widget bookingContainerItem(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            offset: Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void showBookingMenu(ParkingSlotModel slot) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // height: 200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Confirm booking",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: bookingContainerItem(slot.name, "Parking place"),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: bookingContainerItem("5.4\$", "Per hour"),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "5.4\$",
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(
                      //         fontSize: 24,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     Text(
                      //       "Per hour",
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(color: Colors.grey, fontSize: 14),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(width: 16),
                      Expanded(
                        child:
                            BlocConsumer<
                              ParkingBookingBloc,
                              ParkingBookingState
                            >(
                              listener: (context, state) async {
                                if (state is ParkingBookingSuccess) {
                                  ToastUtils.showSuccess(
                                    context,
                                    state.message,
                                  );
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BookingSlotsScreen(),
                                    ),
                                  );
                                }
                                if (state is ParkingBookingError) {
                                  ToastUtils.showError(context, state.message);
                                }
                              },
                              builder: (context, state) {
                                // return GestureDetector(
                                //   onTap: () {
                                //     // Provider.of<ParkingProvider>(
                                //     //   context,
                                //     //   listen: false,
                                //     // ).slotBooking(
                                //     //   widget.parkingId,
                                //     //   // slot.id,
                                //     //   1,
                                //     //   selectedGarage,
                                //     //   true,
                                //     // );

                                //     context.read<ParkingBookingBloc>().add(
                                //       ParkingSlotBookingEvent(
                                //         booking: BookingModel(
                                //           id: "UniqueKey",
                                //           userId: "userId",
                                //           parkingId: widget.parkingId,
                                //           areaId: widget.parkingId,
                                //           slotId: slot.id,
                                //           timestamp: -1,
                                //           index: 0,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: Container(
                                //     height: 60,
                                //     decoration: BoxDecoration(
                                //       color: Colors.blue,
                                //       borderRadius: BorderRadius.all(
                                //         Radius.circular(20),
                                //       ),
                                //     ),
                                //     padding: EdgeInsets.all(10),
                                //     alignment: Alignment.center,
                                //     child: Text(
                                //       "Book",
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // );

                                return ActionSlider.standard(
                                  child: const Text('Buyurtma berish'),
                                  action: (controller) async {
                                    controller
                                        .loading(); //starts loading animation

                                    final parkingSlot = BookingModel(
                                      id: "",
                                      userId: "",
                                      parkingId: widget.parking.id,
                                      slotId: slot.id,
                                      timestamp: DateTime.now().toIso8601String(),
                                      index: selectedindex,
                                      parkingModel: widget.parking,
                                      slotName: slot.name,
                                    );
                                    context.read<ParkingBookingBloc>().add(
                                      ParkingSlotBookingEvent(
                                        booking: parkingSlot,
                                      ),
                                    );
                                    BlocListener<
                                      ParkingBookingBloc,
                                      ParkingBookingState
                                    >(
                                      listener: (context, state) {
                                        state is ParkingBookingSuccess
                                            ? controller.success()
                                            : controller.failure();
                                      },
                                    );

                                    setState(() {
                                      selectedSlotId = "";
                                      selectedSlot = null;
                                      selectedindex = -1;
                                    });
                                    //starts success animation
                                  },
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ParkingAreaBloc>(
      context,
    ).add(GetParkingAreasEvent(parkingId: widget.parking.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "WaterLoo Parking",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Text(
              'Joylashuv',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: BlocBuilder<ParkingAreaBloc, ParkingAreaState>(
            builder: (context, state) {
              if (state is ParkingAreaLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ParkingAreaLoaded) {
                final data = state.area;
                final currentSlots = data.slots;

                return Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // horizontal scroll
                      child: SizedBox(
                        width: 3 * 82,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // bo‘yicha qatordagi slotlar
                                mainAxisSpacing: 130,
                                // crossAxisSpacing: 0,
                                childAspectRatio: 60 / 120, // slot width/height
                              ),
                          itemCount: currentSlots.length,
                          itemBuilder: (context, index) {
                            final slot = currentSlots[index];
                            // print("slot ${slot}");
                            return GestureDetector(
                              onTap: slot.isOccupied
                                  ? () {
                                      setState(() {
                                        selectedSlot = slot;
                                        selectedSlotId =
                                            selectedSlotId != slot.id
                                            ? slot.id
                                            : "";
                                        selectedindex = index;
                                      });
                                    }
                                  : null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // SizedBox(width: 10),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    lineThickness: 1.0,
                                    dashLength: 2.0,
                                    dashColor: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 120,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: selectedSlotId == slot.id
                                          ? Colors.blue
                                          : slot.isOccupied
                                          ? Color(0xFFF4F4F4)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: selectedSlotId == slot.id
                                            ? Colors.blue
                                            : slot.isOccupied
                                            ? Colors.grey.shade300
                                            : Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: slot.isOccupied
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${slot.name}",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      selectedSlotId == slot.id
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "Available",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      selectedSlotId == slot.id
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Image.asset(
                                            'assets/images/image.png',
                                          ),
                                  ),
                                  SizedBox(width: 10),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    lineThickness: 1.0,
                                    dashLength: 2.0,
                                    dashColor: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: selectedSlotId.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                selectedSlot != null
                                    ? showBookingMenu(selectedSlot!)
                                    : () {};
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
          // child: StreamBuilder(

          //   builder: (context, asyncSnapshot) {
          //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          //       return Center(child: CircularProgressIndicator());
          //     } else if (asyncSnapshot.connectionState ==
          //         ConnectionState.active) {
          //       final data = asyncSnapshot.data;
          //       // print(data!.garages);
          //       if (!data!.garages.containsKey(selectedGarage)) {
          //         return Center(child: Text('Tanlangan garaj mavjud emas'));
          //       }

          //       final currentSlots = data.garages[selectedGarage]!;

          //       return Stack(
          //         children: [
          //           SingleChildScrollView(
          //             scrollDirection: Axis.horizontal, // horizontal scroll
          //             child: SizedBox(
          //               width: 3 * 200, // har bir slot + padding
          //               child: GridView.builder(

          //                 shrinkWrap: true,
          //                 gridDelegate:
          //                     SliverGridDelegateWithFixedCrossAxisCount(
          //                       crossAxisCount: 3, // bo‘yicha qatordagi slotlar
          //                       // mainAxisSpacing: 10,
          //                       crossAxisSpacing: 50,
          //                       childAspectRatio: 120 / 60, // slot width/height
          //                     ),
          //                 itemCount: currentSlots.length,
          //                 itemBuilder: (context, index) {
          //                   final slot = currentSlots[index];
          //                   print("slot ${slot}");
          //                   return GestureDetector(
          //                     onTap: slot.isOccupied
          //                         ? () {
          //                             setState(() {
          //                               selectedSlot = slot;
          //                               selectedSlotId =
          //                                   selectedSlotId != slot.id
          //                                   ? slot.id
          //                                   : "";
          //                             });
          //                           }
          //                         : null,
          //                     child: Column(
          //                       children: [
          //                         SizedBox(height: 10),
          //                         DottedLine(
          //                           direction: Axis.horizontal,
          //                           lineThickness: 1.0,
          //                           dashLength: 2.0,
          //                           dashColor: Colors.black,
          //                         ),
          //                         SizedBox(height: 10),
          //                         Container(
          //                           width: 130,
          //                           height: 60,
          //                           decoration: BoxDecoration(
          //                             color: selectedSlotId == slot.id
          //                                 ? Colors.blue
          //                                 : slot.isOccupied
          //                                 ? Color(0xFFF4F4F4)
          //                                 : Colors.white,
          //                             borderRadius: BorderRadius.circular(16),
          //                             border: Border.all(
          //                               color: selectedSlotId == slot.id
          //                                   ? Colors.blue
          //                                   : slot.isOccupied
          //                                   ? Colors.grey.shade300
          //                                   : Colors.white,
          //                               width: 1,
          //                             ),
          //                           ),
          //                           child: slot.isOccupied
          //                               ? Column(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.center,
          //                                   children: [
          //                                     Text(
          //                                       "${slot.number}",
          //                                       style: TextStyle(
          //                                         fontSize: 20,
          //                                         fontWeight: FontWeight.bold,
          //                                         color:
          //                                             selectedSlotId == slot.id
          //                                             ? Colors.white
          //                                             : Colors.black,
          //                                       ),
          //                                     ),
          //                                     const SizedBox(height: 4),
          //                                     Text(
          //                                       "Available",
          //                                       style: TextStyle(
          //                                         color:
          //                                             selectedSlotId == slot.id
          //                                             ? Colors.white
          //                                             : Colors.grey,
          //                                         fontWeight: FontWeight.w500,
          //                                       ),
          //                                     ),
          //                                   ],
          //                                 )
          //                               : Image.asset(
          //                                   'assets/images/image.png',
          //                                 ),
          //                         ),
          //                       ],
          //                     ),
          //                   );
          //                 },
          //               ),
          //             ),
          //           ),

          //           Positioned(
          //             bottom: 16,
          //             right: 16,
          //             left: 16,
          //             child: selectedSlotId.isNotEmpty
          //                 ? GestureDetector(
          //                     onTap: () {
          //                       selectedSlot != null
          //                           ? showBookingMenu(selectedSlot!)
          //                           : () {};
          //                     },
          //                     child: Container(
          //                       width: MediaQuery.of(context).size.width,
          //                       height: 60,
          //                       decoration: BoxDecoration(
          //                         color: Colors.blue,
          //                         borderRadius: BorderRadius.all(
          //                           Radius.circular(20),
          //                         ),
          //                       ),
          //                       padding: EdgeInsets.all(10),
          //                       alignment: Alignment.center,
          //                       child: Text(
          //                         "Continue",
          //                         style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 18,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   )
          //                 : SizedBox(),
          //           ),
          //         ],
          //       );

          //     } else {
          //       return SizedBox();
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}
