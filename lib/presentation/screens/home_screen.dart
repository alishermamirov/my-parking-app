import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_parking_app/logic/bloc/user_bloc.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_state.dart';
import 'package:my_parking_app/presentation/widgets/parking_item_tile.dart';

import '../widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return Header(title: "Welcome, ${state.user.userName}");
              } else {
                return Header(title: "Welcome");
              }
            },
          ),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/map');
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                SizedBox(width: 8),
                Text(
                  "Find parking",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "Recent place",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ParkingBloc, ParkingState>(
                  builder: (context, state) {
                    if (state is ParkingLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is ParkingDone) {
                      final list = state.parkings.take(4).toList();

                      final parkingData = list;
                      print(parkingData[0].id);
                      ;
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: parkingData.length > 4
                            ? 4
                            : parkingData.length,
                        padding: EdgeInsets.all(10),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          final data = parkingData[index];
                          return ParkingItemTile(maxHeight: 260, data: data);
                        },
                      );
                    } else {
                      return const Text("Error loading data");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.3,
        //   child: BlocBuilder<ParkingBloc, ParkingState>(
        //     builder: (context, state) {
        //       return StreamBuilder(
        //         stream: Provider.of<ParkingProvider>(
        //           context,
        //         ).streamParkings(),
        //         builder: (context, asyncSnapshot) {
        //           if (asyncSnapshot.connectionState ==
        //               ConnectionState.waiting) {
        //             return Center(child: CircularProgressIndicator());
        //           } else if (asyncSnapshot.connectionState ==
        //               ConnectionState.active) {
        //             final parkingData = asyncSnapshot.data;
        //             return LayoutBuilder(
        //               builder: (context, constraints) {
        //                 print(constraints.maxHeight);
        //                 return parkingData != null
        //                     ? SizedBox(
        //                         height: constraints.maxHeight,
        //                         child: ListView.builder(
        //                           scrollDirection: Axis.horizontal,
        //                           itemCount: parkingData.length > 4
        //                               ? 4
        //                               : parkingData.length,
        //                           padding: EdgeInsets.all(10),
        //                           itemBuilder: (context, index) {
        //                             final data = parkingData[index];
        //                             return RecentPlaceTile(
        //                               maxHeight: constraints.maxHeight,
        //                               data: data,
        //                             );
        //                           },
        //                         ),
        //                       )
        //                     : SizedBox(child: Text("null"));
        //               },
        //             );
        //           } else {
        //             return Center(child: Text("Nimadir"));
        //           }
        //         },
        //       );
        //     },
        //   ),
        // ),
        // SizedBox(height: 16),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         "Favorite place",
        //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        //       ),
        //       Spacer(),
        //       Text(
        //         "See all",
        //         style: TextStyle(
        //           fontWeight: FontWeight.w600,
        //           fontSize: 14,
        //           color: Colors.blue,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // StreamBuilder(
        //   stream: Provider.of<ParkingProvider>(
        //     context,
        //   ).streamFavoriteParkings(),
        //   builder: (context, asyncSnapshot) {
        //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (asyncSnapshot.connectionState ==
        //         ConnectionState.active) {
        //       final favoriteData = asyncSnapshot.data;
        //       return favoriteData != null
        //           ? ListView.separated(
        //               physics: NeverScrollableScrollPhysics(),
        //               shrinkWrap: true,
        //               scrollDirection: Axis.vertical,
        //               itemCount: favoriteData.length < 4
        //                   ? favoriteData.length
        //                   : 4,
        //               padding: EdgeInsets.symmetric(
        //                 horizontal: 16,
        //                 vertical: 8,
        //               ),
        //               itemBuilder: (context, index) {
        //                 final data = favoriteData[index];
        //                 return FavoritePlaceTile(data: data);
        //               },
        //               separatorBuilder: (BuildContext context, int index) {
        //                 return SizedBox(height: 10);
        //               },
        //             )
        //           : Center(child: Text("null"));
        //     } else {
        //       return Center(child: Text("Nimadir"));
        //     }
        //   },
        // ),
      ],
    );
  }
}
