import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; // Import for launching Google Maps

class Location extends StatefulWidget {
  final double latitude;
  final double longitude;

  const Location({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(6.9271, 79.8612); // Default to Sri Lanka
  Set<Polyline> _polylines = {}; 

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    String osrmUrl =
        "https://router.project-osrm.org/route/v1/driving/${_currentPosition.longitude},${_currentPosition.latitude};${widget.longitude},${widget.latitude}?overview=full&geometries=geojson";

    final response = await http.get(Uri.parse(osrmUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> coordinates =
          data['routes'][0]['geometry']['coordinates'];

      List<LatLng> points = coordinates.map((coord) {
        return LatLng(coord[1], coord[0]); // OSRM returns [lng, lat]
      }).toList();

      setState(() {
        _polylines = {
          Polyline(
            polylineId: PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: points,
          )
        };
      });
    }
  }

  void _startNavigation() async {
    final Uri googleMapsUrl = Uri.parse(
        "google.navigation:q=${widget.latitude},${widget.longitude}&mode=d");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw "Could not launch Google Maps";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Direction To Customer Address',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 7,
        ),
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentPosition,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ),
          Marker(
            markerId: MarkerId('destination'),
            position: LatLng(widget.latitude, widget.longitude),
          ),
        },
        polylines: _polylines,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "nav",
              backgroundColor: Colors.blueAccent,
              onPressed: _startNavigation,
              child: Icon(Icons.directions_car,color: Colors.white,),
            ),
            SizedBox(width: 20),
            FloatingActionButton(
              heroTag: "zoom",
              backgroundColor: Colors.deepOrange,
              onPressed: () {
                mapController.animateCamera(
                  CameraUpdate.newLatLngBounds(
                    LatLngBounds(
                      southwest: LatLng(
                        _currentPosition.latitude < widget.latitude
                            ? _currentPosition.latitude
                            : widget.latitude,
                        _currentPosition.longitude < widget.longitude
                            ? _currentPosition.longitude
                            : widget.longitude,
                      ),
                      northeast: LatLng(
                        _currentPosition.latitude > widget.latitude
                            ? _currentPosition.latitude
                            : widget.latitude,
                        _currentPosition.longitude > widget.longitude
                            ? _currentPosition.longitude
                            : widget.longitude,
                      ),
                    ),
                    50.0,
                  ),
                );
              },
              child: Icon(Icons.zoom_out_map, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
