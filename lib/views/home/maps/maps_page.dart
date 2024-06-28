import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/bloc/cubit/theme_cubit.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:smart_jakarta/constant/constant.dart' as constant;

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> myMarker = [];
  List placesPrediction = [];

  Future<PlacesAutocomplete?> placeAutoComplete(String query) async {
    const url = 'https://places.googleapis.com/v1/places:autocomplete';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "X-Android-Package": "com.smartjkt.smart_jakarta",
        "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': constant.API_KEY,
      },
      body: jsonEncode(
        {
          "input": query,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final result = placesAutocompleteFromJson(data);
      if (result.suggestions != null) {
        setState(() {
          placesPrediction = result.suggestions;
        });
      }
    } else {
      print('null data');
    }
    return null;
  }

  Future<Position?> getUserLocation() async {
    LocationService locationService = LocationService();

    final userPosition = await locationService.getCurrentPosition();
    return userPosition;
  }

  void pointUserLocation() async {
    final userLocation = await getUserLocation();
    myMarker.add(
      Marker(
        markerId: const MarkerId('UserMark'),
        position: LatLng(userLocation!.latitude, userLocation.longitude),
        infoWindow: const InfoWindow(title: 'Location'),
      ),
    );

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(userLocation.latitude, userLocation.longitude),
      zoom: 18,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  void goToUserLocation() async {
    final userLocation = await getUserLocation();

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(userLocation!.latitude, userLocation.longitude),
      zoom: 18,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

//* TEMP DATA
  final CameraPosition initialLocation = const CameraPosition(
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
    // myMarker.addAll(markerList);
    pointUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(
        appBarTitle: 'Maps',
        userPictPath: 'assets/images/user_img_placeholder.png',
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialLocation,
            markers: Set<Marker>.of(myMarker),
            gestureRecognizers: {
              /// to make the swipe only in maps
              Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
            },
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: TextField(
                  // TODO: ADD CONTROLLER
                  style: TextStyle(
                    color: context.read<ThemeCubit>().state.themeData ==
                            ThemeData.dark()
                        ? Colors.white
                        : Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    hintText: 'What do you want to find?',
                    hintStyle: TextStyle(
                      color: context.read<ThemeCubit>().state.themeData ==
                              ThemeData.dark()
                          ? Colors.white
                          : const Color(0xffA39E9E),
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIconColor:
                        context.read<ThemeCubit>().state.themeData ==
                                ThemeData.dark()
                            ? Colors.white
                            : const Color(0xffA39E9E),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () async => goToUserLocation(),
        // onPressed: () async => placeAutoComplete('polisi'),
        onPressed: () => print(placesPrediction),
        child: const Icon(Icons.location_searching_sharp),
      ),
    );
  }
}
