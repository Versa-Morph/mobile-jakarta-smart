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
  final PanelController _panelController = PanelController();

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
        body: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LocationAcquired) {
              return Stack(
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
                        polylines: (mapsPageState.directions != null)
                            ? {
                                Polyline(
                                  polylineId: const PolylineId('overview_pl'),
                                  color: const Color(0xff0f53ff),
                                  width: 5,
                                  points: mapsPageState
                                      .directions!.polyLinePoints
                                      .map((e) =>
                                          LatLng(e.latitude, e.longitude))
                                      .toList(),
                                )
                              }
                            : {},
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
                          context.read<MapsCubit>().markUserLocation();
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),

                  // FAB 1, close directions
                  BlocBuilder<MapsCubit, MapsState>(
                    builder: (context, state) {
                      if (state.directions != null) {
                        return Positioned(
                          bottom: 60,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            child: Center(
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  context.read<MapsCubit>().clearDirections();
                                  _panelController.close();
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 242, 152, 17),
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

                  // FAB 2
                  Positioned(
                    right: 15,
                    bottom: 60,
                    child: FloatingActionButton.small(
                      onPressed: () {
                        context.read<MapsCubit>().nearbyPlaces();
                      },
                      backgroundColor: const Color.fromARGB(255, 242, 152, 17),
                      child: const Icon(
                        Icons.location_searching_outlined,
                      ),
                    ),
                  ),

                  // Total Direction and Duration
                  BlocBuilder<MapsCubit, MapsState>(builder: (context, state) {
                    if (state.directions != null) {
                      return Positioned(
                        top: 80,
                        left: 150,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 242, 152, 17),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${state.directions!.totalDistance}, ${state.directions!.totalDuration}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),

                  // Bottom Menu
                  BlocBuilder<MapsCubit, MapsState>(
                    builder: (context, state) {
                      final markerIndex = state.markerIndex;
                      if (state.markers.isEmpty) {
                        return const SizedBox();
                      } else {
                        return SlidingUpPanel(
                          minHeight: 55,
                          controller: _panelController,
                          maxHeight: 350,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          panel: BottomMenuPanel(
                            marker: state.markers[markerIndex],
                            onTap: () {
                              context.read<MapsCubit>().getDirections(
                                    origin: state.markers[0].position,
                                    destination:
                                        state.markers[markerIndex].position,
                                  );
                              _panelController.close();
                            },
                          ),
                        );
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
                      onChanged: (query) => context
                          .read<MapsCubit>()
                          .searchPlacesAutoComplete(query),
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
                                final placePrediction = state
                                    .placesSuggestions[index].placePrediction;

                                final placeId = placePrediction.placeId;
                                final placesTitle = placePrediction
                                    .structuredFormat.mainText.text;
                                final placesSubTitle = placePrediction
                                    .structuredFormat.secondaryText?.text;

                                return ListTile(
                                  onTap: () {
                                    // print(placeId);

                                    context
                                        .read<MapsCubit>()
                                        .markPlaces(placeId);
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
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
