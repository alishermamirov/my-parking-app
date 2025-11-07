import 'package:flutter/material.dart';
import 'package:my_parking_app/presentation/screens/parking_slots_screen.dart';

import '../../models/parking_model.dart';

class ParkingItemTile extends StatelessWidget {
  // final ParkingSpot? spot;
  final bool isMap;
  final double maxHeight;
  final bool? isSelected;
  final ParkingModel data;
  ParkingItemTile({
    Key? key,
    required this.maxHeight,
    // this.spot,
    this.isMap = false,
    this.isSelected,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ParkingSlotsScreen(parkingId: data.id),
          ),
        );
      },
      child: Container(
        height: maxHeight,
        width: maxHeight * 1,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          border: Border.all(
            width: isSelected != null && isSelected! ? 1 : 0,
            color: isSelected != null && isSelected!
                ? Colors.blue
                : Colors.white,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                // width: maxHeight * 0.9,
                height: maxHeight / 2,
                child: Image.network(data.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: maxHeight / 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: maxHeight / 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Joylashuv",
                        style: TextStyle(
                          fontSize: maxHeight / 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      // Text(
                      //   "Narxi:13\$",
                      //   style: TextStyle(
                      //     fontSize: maxHeight / 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                  isMap
                      ? InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         SpotDetailScreen(),
                            //   ),
                            // );
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 244, 244, 244),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.navigate_next_outlined),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
