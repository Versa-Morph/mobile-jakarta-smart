import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/views/home/maps/cubit/maps_cubit.dart';
import 'package:smart_jakarta/views/home/maps/widgets/bottom_menu_panel.dart';
import 'package:smart_jakarta/views/home/maps/widgets/custom_search_bar.dart';
import 'package:smart_jakarta/views/home/maps/widgets/search_result.dart';

class MapsPageProvider extends StatelessWidget {
  const MapsPageProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapsCubit(
        locationCubit: context.read<LocationCubit>(),
      )..markUserLocation(),
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
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state.errorMsg.isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(state.errorMsg),
            duration: const Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<MapsCubit>().clearMsg();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HomeAppBar(
          appBarTitle: 'Maps',
          userPictPath: 'assets/images/user_img_placeholder.png',
        ),
        body: Stack(
          children: [
            // Google Maps Widget
            Builder(builder: (context) {
              final mapsPageState = context.watch<MapsCubit>().state;
              final locationState = context.watch<LocationCubit>().state;

              if (locationState is LocationLoading) {
                return const Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (locationState is LocationAcquired) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                        locationState.userLocation.latitude,
                        locationState.userLocation.longitude,
                      ),
                      zoom: 18),
                  markers: Set<Marker>.of(mapsPageState.markers),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  trafficEnabled: true,
                  mapToolbarEnabled: false,
                  gestureRecognizers: {
                    /// to make the swipe only in maps
                    Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer()),
                  },
                  onMapCreated: (controller) {
                    context.read<MapsCubit>().setController(controller);
                  },
                );
              } else {
                return const SizedBox();
              }
            }),

            // FAB
            Positioned(
              right: 15,
              bottom: 60,
              child: FloatingActionButton.small(
                onPressed: () {
                  // context.read<MapsCubit>().nearbyPlaces();
                  print(context.read<MapsCubit>().state.markerIndex);
                  print(context.read<MapsCubit>().state.markers);
                },
                backgroundColor: const Color.fromARGB(255, 242, 152, 17),
                child: const Icon(
                  Icons.location_searching_outlined,
                ),
              ),
            ),

            // Bottom Menu
            BlocBuilder<MapsCubit, MapsState>(
              builder: (context, state) {
                if (state.markers.isNotEmpty) {
                  return SlidingUpPanel(
                    minHeight: 55,
                    maxHeight: 250,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    panel: BottomMenuPanel(
                      marker: state.markers[0],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),

            // SearchBar
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: CustomSearchBar(
                focusNode: context.read<MapsCubit>().focusNode,
                onChanged: (query) =>
                    context.read<MapsCubit>().searchPlacesAutoComplete(query),
              ),
            ),

            // Search Result
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
                          final placePrediction =
                              state.placesSuggestions[index].placePrediction;

                          final placeId = placePrediction.placeId;
                          final placesTitle =
                              placePrediction.structuredFormat.mainText.text;
                          final placesSubTitle = placePrediction
                              .structuredFormat.secondaryText?.text;

                          return ListTile(
                            onTap: () {
                              // print(placeId);

                              context.read<MapsCubit>().markPlaces(placeId);
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
      ),
    );
  }
}
