import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/components/home_appbar.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with AutomaticKeepAliveClientMixin {
  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
    const Marker(
      markerId: MarkerId('myLocation'),
      position: LatLng(
        -6.203581902710393,
        107.00458244057064,
      ),
      infoWindow: InfoWindow(title: 'MyLocation'),
    )
  ];
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(
      -6.203581902710393,
      107.00458244057064,
    ),
    zoom: 18,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const HomeAppBar(
        appBarTitle: 'Maps',
        userPictPath: 'assets/images/user_img_placeholder.png',
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        markers: Set<Marker>.of(myMarker),
        gestureRecognizers: {
          /// to make the swipe only in maps
          Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
        },
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(
                  -6.203581902710393,
                  107.00458244057064,
                ),
                zoom: 18,
              ),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.location_searching_sharp),
      ),
    );
  }
}
