import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/views/home/maps/cubit/maps_cubit.dart';
import 'package:smart_jakarta/views/home/maps/widgets/custom_search_bar.dart';
import 'package:smart_jakarta/views/home/maps/widgets/search_result.dart';

class MapsPageWrapper extends StatelessWidget {
  const MapsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapsCubit(),
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
          BlocBuilder<MapsCubit, MapsState>(
            builder: (context, state) {
              return GoogleMap(
                initialCameraPosition:
                    const CameraPosition(target: LatLng(0, 0), zoom: 18),
                markers: Set<Marker>.of(state.markers),
                gestureRecognizers: {
                  /// to make the swipe only in maps
                  Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer()),
                },
                onMapCreated: (controller) {
                  context.read<MapsCubit>().setController(controller);
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: false,
                trafficEnabled: true,
              );
            },
          ),
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
      floatingActionButton: BlocBuilder<MapsCubit, MapsState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<MapsCubit>().goToUserLocation();
            },
            child: const Icon(
              Icons.location_searching_outlined,
            ),
          );
        },
      ),
    );
  }
}
