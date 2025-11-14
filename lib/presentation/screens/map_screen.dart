// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
// import 'package:my_parking_app/models/parking_model.dart';
// import 'package:my_parking_app/presentation/widgets/parking_item_tile.dart';

// import '../../logic/parking_bloc/parking_state.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _mapController;
//   final _searchCtrl = TextEditingController();
//   Set<Marker> _markers = {};
//   bool _mapReady = false;
//   bool _permissionDenied = false;
//   // List<ParkingSpot> _lastSpots = [];

//   static const CameraPosition _initialCamera = CameraPosition(
//     target: LatLng(41.3126, 69.2797),
//     zoom: 14.0,
//   );

//   @override
//   void initState() {
//     super.initState();
//     //   Future.microtask(() {
//     //     final prov = Provider.of<ParkingProvider>(context, listen: false);
//     //     prov.clearSearch();
//     //     prov.search('');
//     //   });
//     _requestPermissionAndLocate();
//     getData();
//   }

//   @override
//   void dispose() {
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _requestPermissionAndLocate() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // ignore for demo
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       setState(() => _permissionDenied = true);
//       return;
//     }
//     final pos = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     // Provider.of<ParkingProvider>(context, listen: false).updatePosition(pos);
//     if (_mapReady) {
//       _mapController.animateCamera(
//         CameraUpdate.newLatLngZoom(LatLng(pos.latitude, pos.longitude), 15),
//       );
//     }
//   }

//   void animateCamera(double lat, double long) {
//     _mapController.animateCamera(
//       CameraUpdate.newLatLngZoom(LatLng(lat, long), 15),
//     );
//   }

//   void _updateMarkers(List<ParkingModel> data, {String? highlightId}) {
//     // final prov = Provider.of<ParkingProvider>(context, listen: false);
//     // final current = prov.currentPosition;
//     final newMarkers = <Marker>{};
//     for (var parking in data) {
//       // final hue = s.id == highlightId
//       //     ? BitmapDescriptor.hueAzure
//       //     : (s.freeCount() > 0
//       //           ? BitmapDescriptor.hueGreen
//       //           : BitmapDescriptor.hueRed);
//       newMarkers.add(
//         Marker(
//           markerId: MarkerId(parking.id),
//           position: LatLng(parking.lat, parking.long),
//           // icon: BitmapDescriptor.defaultMarkerWithHue(hue),
//           infoWindow: InfoWindow(
//             title: parking.image,
//             snippet: '\${s.freeCount()}/\${s.totalCount()} free',
//           ),
//           onTap: () {
//             // prov.selectSpot(s);
//             // _showSpotDetail(s);
//           },
//         ),
//       );
//     }
//     // if (current != null) {
//     //   newMarkers.add(
//     //     Marker(
//     //       markerId: const MarkerId('me'),
//     //       position: LatLng(current.latitude, current.longitude),
//     //       icon: BitmapDescriptor.defaultMarkerWithHue(
//     //         BitmapDescriptor.hueViolet,
//     //       ),
//     //       infoWindow: const InfoWindow(title: 'You'),
//     //     ),
//     //   );
//     // }
//     setState(() => _markers = newMarkers);
//   }

//   // Future<void> _showSpotDetail(ParkingSpot s) async {
//   //   final prov = Provider.of<ParkingProvider>(context, listen: false);
//   //   prov.selectSpot(s);
//   //   // await showModalBottomSheet(
//   //   //   context: context,

//   //   //   builder: (_) => SpotDetailSheet(spot: s),
//   //   //   isScrollControlled: true,
//   //   // );

//   //   _updateMarkers(prov.filteredSpots, highlightId: prov.selectedSpot?.id);
//   // }

//   void getData() {
//     context.read<ParkingBloc>().add(GetParkingEvent());
//   }

//   int currentIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     // final prov = Provider.of<ParkingProvider>(context);
//     // if (_lastSpots != prov.filteredSpots) {
//     //   WidgetsBinding.instance.addPostFrameCallback((_) {
//     //     if (_mapReady)
//     //       _updateMarkers(
//     //         prov.filteredSpots,
//     //         highlightId: prov.selectedSpot?.id,
//     //       );
//     //   });
//     //   _lastSpots = prov.filteredSpots;
//     // }
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.grey,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: GoogleMap(
//                 initialCameraPosition: _initialCamera,
//                 markers: _markers,
//                 myLocationEnabled: true,
//                 onMapCreated: (controller) {
//                   _mapController = controller;
//                   setState(() => _mapReady = true);
//                   // final pos = Provider.of<ParkingProvider>(
//                   //   context,
//                   //   listen: false,
//                   // ).currentPosition;
//                   // if (pos != null) {
//                   //   _mapController.animateCamera(
//                   //     CameraUpdate.newLatLngZoom(
//                   //       LatLng(pos.latitude, pos.longitude),
//                   //       15,
//                   //     ),
//                   //   );
//                   // }
//                   // _updateMarkers(
//                   //   Provider.of<ParkingProvider>(
//                   //     context,
//                   //     listen: false,
//                   //   ).filteredSpots,
//                   // );
//                 },
//               ),
//             ),

//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: IconButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         icon: const Icon(Icons.arrow_back_ios_rounded),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: TextField(
//                         controller: _searchCtrl,
//                         decoration: InputDecoration(
//                           hintText: 'Search place or "lat,lng"',
//                           prefixIcon: const Icon(Icons.search),
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 12,
//                             horizontal: 10,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         onChanged: (v) {
//                           if (v.trim().isEmpty) {
//                             // Provider.of<ParkingProvider>(
//                             //   context,
//                             //   listen: false,
//                             // ).clearSearch();
//                           } else {
//                             // Provider.of<ParkingProvider>(
//                             //   context,
//                             //   listen: false,
//                             // ).search(v);
//                           }
//                           // _updateMarkers(
//                           //   Provider.of<ParkingProvider>(
//                           //     context,
//                           //     listen: false,
//                           //   ).filteredSpots,
//                           // );
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: IconButton(
//                         onPressed: () => _requestPermissionAndLocate(),
//                         icon: const Icon(Icons.my_location),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             Positioned(
//               bottom: 16,
//               left: 0,
//               right: 0,
//               child: BlocBuilder<ParkingBloc, ParkingState>(
//                 builder: (context, state) {
//                   if (state is ParkingLoading) {
//                     return CircularProgressIndicator();
//                   } else if (state is ParkingDone) {
//                     final parkings = state.parkings;
//                     _updateMarkers(parkings);
//                     return SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.22,
//                       child: LayoutBuilder(
//                         builder: (context, constraints) {
//                           return SizedBox(
//                             height: constraints.maxHeight,

//                             child: CarouselSlider(
//                               items: List.generate(parkings.length, (index) {
//                                 return ParkingItemTile(
//                                   maxHeight: constraints.maxHeight,
//                                   isMap: true,
//                                   data: parkings[index],
//                                   isSelected: index == currentIndex,
//                                 );
//                               }),

//                               options: CarouselOptions(
//                                 enableInfiniteScroll: true,
//                                 initialPage: 0,
//                                 onPageChanged: (index, reason) {
//                                   setState(() {
//                                     animateCamera(
//                                       parkings[currentIndex].lat,
//                                       parkings[currentIndex].long,
//                                     );
//                                     currentIndex = index;
//                                   });
//                                 },
//                                 disableCenter: true,
//                                 enlargeCenterPage: true,
//                                 viewportFraction: 0.7,
//                                 padEnds: true,
//                               ),
//                             ),

//                             // CarouselSlider.builder(
//                             //   key: ValueKey("carousel1"),

//                             //   itemCount: parkings.length,
//                             //   itemBuilder: (context, index, realIndex) {
//                             //     print(realIndex);
//                             //     // print(index);

//                             //     return ParkingItemTile(
//                             //       // isSelected: currentIndex == index,
//                             //       maxHeight: constraints.maxHeight,
//                             //       isMap: true,
//                             //       data: parkings[index],
//                             //       isSelected: index == realIndex,
//                             //       // spot: s,
//                             //     );
//                             //   },
//                             //   options: CarouselOptions(
//                             //     enableInfiniteScroll: false,
//                             //     initialPage: 0,
//                             //     onPageChanged: (index, reason) {
//                             //       // print(index);
//                             //     },
//                             //     disableCenter: true,
//                             //     enlargeCenterPage: true,
//                             //     viewportFraction: 0.52,
//                             //     padEnds: false,
//                             //   ),
//                             // ),
//                             // child: ListView.builder(
//                             //   scrollDirection: Axis.horizontal,
//                             //   itemCount: state.parkings.length,
//                             //   padding: EdgeInsets.all(10),

//                             //   itemBuilder: (context, index) {
//                             //     final parking = parkings[index];
//                             //     int currentIndex = -1;
//                             //     // final e = prov.nearestSorted()[index];
//                             //     // final s = e.key;
//                             //     // final d = e.value;
//                             //     return GestureDetector(
//                             //       onTap: () {
//                             //         setState(() {
//                             //           currentIndex = index;
//                             //         });
//                             //         _mapController.animateCamera(
//                             //           CameraUpdate.newLatLngZoom(
//                             //             LatLng(parking.lat, parking.long),
//                             //             17,
//                             //           ),
//                             //         );
//                             //         // prov.selectSpot(s);
//                             //         // _showSpotDetail(s);
//                             //         print(currentIndex == index);
//                             //       },
//                             //       child: ParkingItemTile(
//                             //         // isSelected: currentIndex == index,
//                             //         maxHeight: constraints.maxHeight,
//                             //         isMap: true,
//                             //         data: parking,
//                             //         // spot: s,
//                             //       ),
//                             //     );
//                             //   },
//                             // ),
//                           );
//                         },
//                       ),
//                     );
//                   } else {
//                     return SizedBox();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
import 'package:my_parking_app/models/parking_model.dart';
import 'package:my_parking_app/presentation/widgets/parking_item_tile.dart';

import '../../logic/parking_bloc/parking_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  final _searchCtrl = TextEditingController();
  Set<Marker> _markers = {};

  bool _mapReady = false;
  bool _permissionDenied = false;

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(41.3126, 69.2797),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLocate();
    context.read<ParkingBloc>().add(GetParkingEvent());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissionAndLocate() async { if (!mounted) return;    
    bool enabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission p = await Geolocator.checkPermission();

    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
    }

    if (p == LocationPermission.denied ||
        p == LocationPermission.deniedForever) {
      setState(() => _permissionDenied = true);
      return;
    }

    final pos = await Geolocator.getCurrentPosition();
  if (!mounted) return;
    animateCamera(pos.latitude, pos.longitude);
  }

  void animateCamera(double lat, double lng) {
    if (!mounted) return; // <-- eng muhim joy
    // if (_mapController == null) return;
    if (_mapReady) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
      );
    }
  }

  void _updateMarkers(List<ParkingModel> data) {
    final newMarkers = <Marker>{};
    List.generate(data.length, (index) {
      newMarkers.add(
        Marker(
          markerId: MarkerId(data[index].id),
          position: LatLng(data[index].lat, data[index].long),
          infoWindow: InfoWindow(title: data[index].name),
          onTap: () {
            carouselController.animateToPage(index);
          },
        ),
      );
    });

    setState(() => _markers = newMarkers);
  }

  int currentIndex = 0;
  final carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: _initialCamera,
                markers: _markers,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _mapController = controller;
                  setState(() => _mapReady = true);
                },
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchCtrl,
                        decoration: InputDecoration(
                          hintText: "Search place",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: _requestPermissionAndLocate,
                        icon: const Icon(Icons.my_location),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 16,
              left: 0,
              right: 0,

              child: BlocListener<ParkingBloc, ParkingState>(
                listener: (context, state) {
                  if (state is ParkingDone) {
                    _updateMarkers(state.parkings);
                  }
                },

                child: BlocBuilder<ParkingBloc, ParkingState>(
                  builder: (context, state) {
                    if (state is ParkingLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ParkingDone) {
                      final list = state.parkings;

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.23,
                        child: CarouselSlider(
                          carouselController: carouselController,
                          items: List.generate(list.length, (i) {
                            return ParkingItemTile(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.23,
                              data: list[i],
                              isSelected: i == currentIndex,
                            );
                          }),

                          options: CarouselOptions(
                            disableCenter: true,
                            enlargeCenterPage: false,
                            initialPage: 0,
                            // height: 180,
                            viewportFraction: 0.7,
                            onPageChanged: (index, reason) {
                              setState(() => currentIndex = index);

                              animateCamera(list[index].lat, list[index].long);
                            },
                          ),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
