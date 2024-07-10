import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomMenuPanel extends StatelessWidget {
  const BottomMenuPanel({
    super.key,
    required this.marker,
    this.onTap,
  });
  final Marker marker;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Place Title
          Text(
            marker.infoWindow.title!,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 23.0,
            ),
          ),
          // Place Location
          Text('${marker.position.latitude}, ${marker.position.longitude}'),
          const SizedBox(height: 5),

          // Direction Button
          (marker.mapsId.value == '0')
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 242, 152, 17),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.directions,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Directions',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

          const SizedBox(height: 5),

          // Place Address
          Row(
            children: [
              const ImageIcon(
                AssetImage('assets/icons/location_icon.png'),
                color: Color(0xffD99022),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(marker.infoWindow.snippet ?? '')),
            ],
          )
        ],
      ),
    );
  }
}
