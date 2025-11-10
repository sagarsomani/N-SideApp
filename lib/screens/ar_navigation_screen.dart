import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:n_side_app/models/departments_data.dart';
import 'package:n_side_app/services/directions_repository.dart';
import 'package:n_side_app/.env.dart';
import 'package:n_side_app/models/directions_model.dart';

class NavigationMapScreen extends StatefulWidget {
  const NavigationMapScreen({super.key});

  @override
  State<NavigationMapScreen> createState() => _NavigationMapScreenState();
}

class _NavigationMapScreenState extends State<NavigationMapScreen> {
  late GoogleMapController _controller;
  Marker? _userMarker;
  Marker? _destinationMarker;
  Directions? _directions;
  StreamSubscription<Position>? _positionStream;

  TextEditingController _searchController = TextEditingController();
  List<Department> _searchResults = [];

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(25.4202, 68.2617),
    zoom: 16,
  ); // MUET

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  Future<void> _startLocationUpdates() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 5,
          ),
        ).listen((position) async {
          LatLng userLatLng = LatLng(position.latitude, position.longitude);
          setState(() {
            _userMarker = Marker(
              markerId: const MarkerId('user'),
              position: userLatLng,
              infoWindow: const InfoWindow(title: 'Your Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
            );
          });

          // Update directions if destination is already set
          if (_destinationMarker != null) {
            await _getDirections(userLatLng, _destinationMarker!.position);
          }

          // Move camera to user location
          _controller.animateCamera(CameraUpdate.newLatLng(userLatLng));
        });
  }

  Future<void> _getDirections(LatLng origin, LatLng destination) async {
    final directions = await DirectionsRepository().getDirections(
      origin: origin,
      destination: destination,
      googleAPIKey: googleAPIKey, // from your .env
    );
    if (directions != null) {
      setState(() {
        _directions = directions;
      });
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigation Map")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _controller = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: {
              if (_userMarker != null) _userMarker!,
              if (_destinationMarker != null) _destinationMarker!,
            },
            polylines: _directions != null
                ? {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      color: Colors.red,
                      width: 5,
                      points: _directions!.polylinePoints
                          .map((p) => LatLng(p.latitude, p.longitude))
                          .toList(),
                    ),
                  }
                : {},
            onTap: (pos) async {
              setState(() {
                _destinationMarker = Marker(
                  markerId: const MarkerId('destination'),
                  position: pos,
                  infoWindow: const InfoWindow(title: 'Destination'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange,
                  ),
                );
              });
              if (_userMarker != null) {
                await _getDirections(_userMarker!.position, pos);
              }
            },
          ),

          // --- SEARCH BAR ---
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search Department",
                    filled: true,
                    fillColor: const Color.fromRGBO(255, 255, 255, 1),
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchResults = muetDepartments
                          .where(
                            (d) => d.name.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                          )
                          .toList();
                    });
                  },
                ),
                if (_searchResults.isNotEmpty)
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final dept = _searchResults[index];
                        return ListTile(
                          title: Text(dept.name),
                          onTap: () async {
                            setState(() {
                              _destinationMarker = Marker(
                                markerId: MarkerId(dept.name),
                                position: dept.location,
                                infoWindow: InfoWindow(title: dept.name),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueOrange,
                                ),
                              );
                              _searchController.clear();
                              _searchResults.clear();
                            });

                            // Move camera to department
                            _controller.animateCamera(
                              CameraUpdate.newLatLngZoom(dept.location, 17),
                            );

                            // Get directions from user to selected department
                            if (_userMarker != null) {
                              await _getDirections(
                                _userMarker!.position,
                                dept.location,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // --- DIRECTIONS INFO ---
          if (_directions != null)
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  'Distance: ${_directions!.totalDistance}, Duration: ${_directions!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.my_location),
        onPressed: () {
          if (_userMarker != null) {
            _controller.animateCamera(
              CameraUpdate.newLatLng(_userMarker!.position),
            );
          }
        },
      ),
    );
  }
}
