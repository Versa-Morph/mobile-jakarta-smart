import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:smart_jakarta/constant/constant.dart' as constant;
import 'package:smart_jakarta/views/home/maps/widgets/custom_search_bar.dart';
import 'package:smart_jakarta/views/home/maps/widgets/search_result.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();
  final List<Marker> myMarker = [];
  List<Suggestion> places = [];
  bool isResultVisible = false;

  Future<PlacesAutocomplete?> searchAutoComplete(String query) async {
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
      // final data = jsonDecode(response.body);
      final result = placesAutocompleteFromJson(response.body);

      setState(() {
        places = result.suggestions;
      });
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

    setState(() {
      if (places.isEmpty) {
        isResultVisible = false;
      } else {
        isResultVisible = true;
      }
    });
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
            child: CustomSearchBar(
              // TODO: ADD CONTROLLER
              controller: _searchController,
              onChanged: (query) => searchAutoComplete(query),
            ),
          ),
          SearchResult(
            isVisible: isResultVisible,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: places.length,
              itemBuilder: (context, index) {
                final placesTitle = places[index]
                    .placePrediction
                    .structuredFormat
                    .mainText
                    .text;
                final placesSubTitle = places[index]
                    .placePrediction
                    .structuredFormat
                    .secondaryText
                    ?.text;

                return ListTile(
                  onTap: () {},
                  title: Text(placesTitle),
                  subtitle: Text(placesSubTitle ?? ''),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () async => goToUserLocation(),
        // onPressed: () async => placeAutoComplete('polisi'),
        onPressed: () async {
          searchAutoComplete(_searchController.text);
          print(isResultVisible);
        },
        child: const Icon(Icons.location_searching_sharp),
      ),
    );
  }
}
