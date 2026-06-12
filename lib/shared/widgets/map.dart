import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// Import Google Maps
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

// Import Flutter Map (Aliased to avoid naming conflicts)
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:latlong2/latlong.dart' as ll;

class AppMapMarker {
  final String id;
  final String title;
  final double latitude;
  final double longitude;

  const AppMapMarker({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
  });
}

class AppMap extends StatelessWidget {
  final List<AppMapMarker> markers;
  final double height;
  final double zoom;

  const AppMap({
    super.key,
    required this.markers,
    this.height = 400,
    this.zoom = 12,
  });

  // Determines if the current platform fully supports Google Maps
  bool get _useGoogleMaps {
    if (kIsWeb) return true;
    if (Platform.isAndroid || Platform.isIOS) return true;
    return false; // Returns false for Linux, Windows, and macOS
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: _useGoogleMaps ? _buildGoogleMap() : _buildFlutterMap(),
    );
  }

  // Mobile & Web Implementation
  Widget _buildGoogleMap() {
    final initialPosition = markers.isNotEmpty
        ? gmaps.LatLng(markers.first.latitude, markers.first.longitude)
        : const gmaps.LatLng(0, 0);

    return gmaps.GoogleMap(
      initialCameraPosition: gmaps.CameraPosition(
        target: initialPosition,
        zoom: zoom,
      ),
      markers: markers
          .map(
            (marker) => gmaps.Marker(
              markerId: gmaps.MarkerId(marker.id),
              position: gmaps.LatLng(marker.latitude, marker.longitude),
              infoWindow: gmaps.InfoWindow(title: marker.title),
            ),
          )
          .toSet(),
    );
  }

  // Desktop (Linux, Windows, macOS) Implementation
  Widget _buildFlutterMap() {
    final initialPosition = markers.isNotEmpty
        ? ll.LatLng(markers.first.latitude, markers.first.longitude)
        : const ll.LatLng(0, 0);
    return fmap.FlutterMap(
      options: fmap.MapOptions(
        initialCenter: initialPosition,
        initialZoom: zoom,
      ),
      children: [
        fmap.TileLayer(
          urlTemplate: 'https://openstreetmap.org{z}/{x}/{y}.png', // Fixed URL
          userAgentPackageName: 'com.codearte.stock_app',
        ),
        fmap.MarkerLayer(
          markers: markers.map((marker) {
            return fmap.Marker(
              point: ll.LatLng(marker.latitude, marker.longitude),
              width: 40,
              height: 40,
              child: Tooltip(
                message: marker.title,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
