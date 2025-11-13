import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_parking_app/logic/parking_bloc/parking_bloc.dart';
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
  // List<ParkingSpot> _lastSpots = [];

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(41.3126, 69.2797),
    zoom: 14.0,
  );

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     final prov = Provider.of<ParkingProvider>(context, listen: false);
  //     prov.clearSearch();
  //     prov.search('');
  //   });
  //   _requestPermissionAndLocate();
  // }

  // @override
  // void dispose() {
  //   _searchCtrl.dispose();
  //   super.dispose();
  // }

  Future<void> _requestPermissionAndLocate() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore for demo
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() => _permissionDenied = true);
      return;
    }
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // Provider.of<ParkingProvider>(context, listen: false).updatePosition(pos);
    if (_mapReady) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(pos.latitude, pos.longitude), 15),
      );
    }
  }

  // void _updateMarkers(List<ParkingSpot> spots, {String? highlightId}) {
  //   final prov = Provider.of<ParkingProvider>(context, listen: false);
  //   final current = prov.currentPosition;
  //   final newMarkers = <Marker>{};
  //   for (var s in spots) {
  //     final hue = s.id == highlightId
  //         ? BitmapDescriptor.hueAzure
  //         : (s.freeCount() > 0
  //               ? BitmapDescriptor.hueGreen
  //               : BitmapDescriptor.hueRed);
  //     newMarkers.add(
  //       Marker(
  //         markerId: MarkerId(s.id),
  //         position: LatLng(s.lat, s.lng),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(hue),
  //         infoWindow: InfoWindow(
  //           title: s.label,
  //           snippet: '\${s.freeCount()}/\${s.totalCount()} free',
  //         ),
  //         onTap: () {
  //           prov.selectSpot(s);
  //           _showSpotDetail(s);
  //         },
  //       ),
  //     );
  //   }
  //   if (current != null) {
  //     newMarkers.add(
  //       Marker(
  //         markerId: const MarkerId('me'),
  //         position: LatLng(current.latitude, current.longitude),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(
  //           BitmapDescriptor.hueViolet,
  //         ),
  //         infoWindow: const InfoWindow(title: 'You'),
  //       ),
  //     );
  //   }
  //   setState(() => _markers = newMarkers);
  // }

  // Future<void> _showSpotDetail(ParkingSpot s) async {
  //   final prov = Provider.of<ParkingProvider>(context, listen: false);
  //   prov.selectSpot(s);
  //   // await showModalBottomSheet(
  //   //   context: context,

  //   //   builder: (_) => SpotDetailSheet(spot: s),
  //   //   isScrollControlled: true,
  //   // );

  //   _updateMarkers(prov.filteredSpots, highlightId: prov.selectedSpot?.id);
  // }

  @override
  Widget build(BuildContext context) {
    // final prov = Provider.of<ParkingProvider>(context);
    // if (_lastSpots != prov.filteredSpots) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     if (_mapReady)
    //       _updateMarkers(
    //         prov.filteredSpots,
    //         highlightId: prov.selectedSpot?.id,
    //       );
    //   });
    //   _lastSpots = prov.filteredSpots;
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  // final pos = Provider.of<ParkingProvider>(
                  //   context,
                  //   listen: false,
                  // ).currentPosition;
                  // if (pos != null) {
                  //   _mapController.animateCamera(
                  //     CameraUpdate.newLatLngZoom(
                  //       LatLng(pos.latitude, pos.longitude),
                  //       15,
                  //     ),
                  //   );
                  // }
                  // _updateMarkers(
                  //   Provider.of<ParkingProvider>(
                  //     context,
                  //     listen: false,
                  //   ).filteredSpots,
                  // );
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
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchCtrl,
                        decoration: InputDecoration(
                          hintText: 'Search place or "lat,lng"',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) {
                          if (v.trim().isEmpty) {
                            // Provider.of<ParkingProvider>(
                            //   context,
                            //   listen: false,
                            // ).clearSearch();
                          } else {
                            // Provider.of<ParkingProvider>(
                            //   context,
                            //   listen: false,
                            // ).search(v);
                          }
                          // _updateMarkers(
                          //   Provider.of<ParkingProvider>(
                          //     context,
                          //     listen: false,
                          //   ).filteredSpots,
                          // );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () => _requestPermissionAndLocate(),
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
              child: BlocBuilder<ParkingBloc, ParkingState>(
                builder: (context, state) {
                  if (state is ParkingLoading) {
                    return CircularProgressIndicator();
                  } else if (state is ParkingDone) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          int currentIndex = -1;
                          return SizedBox(
                            height: constraints.maxHeight,

                            // child: CarouselSlider.builder(
                            //   key: ValueKey("carousel1"),
                            //   itemCount: prov.nearestSorted().length,
                            //   itemBuilder: (context, index, realIndex) {
                            //     print(realIndex);
                            //     print(index);

                            //     return GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           currentIndex = index;
                            //         });
                            //       },
                            //       child: RecentPlaceTile(
                            //         isSelected: currentIndex == index,
                            //         maxHeight: constraints.maxHeight,
                            //       ),
                            //     );
                            //   },
                            //   options: CarouselOptions(
                            //     enableInfiniteScroll: false,
                            //     initialPage: 0,
                            //     disableCenter: true,
                            //     // enlargeCenterPage: true,
                            //     viewportFraction: 0.52,
                            //     padEnds: false,
                            //   ),
                            // ),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.parkings.length,
                              padding: EdgeInsets.all(10),

                              itemBuilder: (context, index) {
                                int currentIndex = -1;
                                // final e = prov.nearestSorted()[index];
                                // final s = e.key;
                                // final d = e.value;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    // _mapController.animateCamera(
                                    //   CameraUpdate.newLatLngZoom(
                                    //     LatLng(s.lat, s.lng),
                                    //     17,
                                    //   ),
                                    // );
                                    // prov.selectSpot(s);
                                    // _showSpotDetail(s);
                                    print(currentIndex == index);
                                  },
                                  child: ParkingItemTile(
                                    // isSelected: currentIndex == index,
                                    maxHeight: constraints.maxHeight,
                                    isMap: true,
                                    // spot: s,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
