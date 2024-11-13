import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as coordinates;

class LocationPicker extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Function(double, double) onCoordinatesChanged;
  final double zoomLevel;
  final bool displayOnly;
  final Color markerColor;

  const LocationPicker({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.onCoordinatesChanged,
    this.zoomLevel = 10.0,
    this.displayOnly = true,
    this.markerColor = Colors.black,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: coordinates.LatLng(
          widget.latitude,
          widget.longitude,
        ),
        initialZoom: widget.zoomLevel,
        onTap: (tapLoc, position) {
          if (!widget.displayOnly) {
            widget.onCoordinatesChanged(
              position.latitude,
              position.longitude,
            );
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 60.0,
              height: 60.0,
              point: coordinates.LatLng(
                widget.latitude,
                widget.longitude,
              ),
              child: Icon(
                Icons.location_pin,
                size: 60.0,
                color: widget.markerColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
