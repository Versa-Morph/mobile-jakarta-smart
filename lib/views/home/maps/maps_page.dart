import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/views/home/maps/cubit/maps_cubit.dart';
import 'package:smart_jakarta/views/home/maps/widgets/custom_search_bar.dart';
import 'package:smart_jakarta/views/home/maps/widgets/search_result.dart';

class MapsPageWrapper extends StatelessWidget {
  const MapsPageWrapper({super.key, this.markerList});
  final List<Marker>? markerList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapsCubit(
        locationCubit: context.read<LocationCubit>(),
      ),
      child: const MapsPage(),
    );
  }
}

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
          Builder(builder: (context) {
            final mapState = context.watch<MapsCubit>().state;
            final locationState = context.watch<LocationCubit>().state;

            if (locationState is LocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (locationState is LocationAcquired) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      locationState.userLocation.latitude,
                      locationState.userLocation.longitude,
                    ),
                    zoom: 18),
                markers: Set<Marker>.of(mapState.markers),
                gestureRecognizers: {
                  /// to make the swipe only in maps
                  Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer()),
                },
                onMapCreated: (controller) {
                  context.read<MapsCubit>().setController(controller);
                },
                myLocationEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: false,
                trafficEnabled: true,
              );
            } else {
              return const SizedBox();
            }
          }),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: CustomSearchBar(
              onChanged: (query) =>
                  context.read<MapsCubit>().searchPlacesAutoComplete(query),
            ),
          ),
          Positioned(
            top: 48,
            right: 15,
            left: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<MapsCubit, MapsState>(
                builder: (context, state) {
                  return SearchResult(
                    isVisible: state.isSearchResultVisible,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.placesSuggestions.length,
                      itemBuilder: (context, index) {
                        final placesTitle = state.placesSuggestions[index]
                            .placePrediction.structuredFormat.mainText.text;
                        final placesSubTitle = state
                            .placesSuggestions[index]
                            .placePrediction
                            .structuredFormat
                            .secondaryText
                            ?.text;

                        return ListTile(
                          onTap: () {
                            print(placesTitle);
                          },
                          title: Text(placesTitle),
                          subtitle: Text(placesSubTitle ?? ''),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MapsCubit>().goToUserLocation();
          context.read<MapsCubit>().nearbyPlaces();
        },
        child: const Icon(
          Icons.location_searching_outlined,
        ),
      ),
    );
  }
}
