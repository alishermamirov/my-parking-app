import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class BookingTileItem extends StatelessWidget {
  const BookingTileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jizzax yoshlar texnoparki",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Joy: A1"),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset("assets/images/image.png", height: 140),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ActionSlider.standard(
              child: const Text('Men keldim'),
              action: (controller) async {
                
                // controller.loading(); //starts loading animation
                // await Future.delayed(const Duration(seconds: 3));
                // controller.success(); //starts success animation
              },
            ),
          ),
        ],
      ),
    );
  }
}
