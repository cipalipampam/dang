import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Untuk mendapatkan lokasi pengguna saat ini

class MapSection extends StatefulWidget {
  const MapSection({Key? key}) : super(key: key);

  @override
  _MapSectionState createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  late MapController
      _mapController; // Gunakan late untuk memastikan ini diinisialisasi
  LatLng? _currentPosition;
  double _currentZoom = 13.5;
  double _radius = 2000;

  @override
  void initState() {
    super.initState();
    _mapController = MapController(); // Inisialisasi MapController di s  ini
    _getCurrentLocation(); // Ambil lokasi pengguna saat inisialisasi
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          print('Current Position: $_currentPosition'); // Log untuk debugging
        });
        // Pindahkan peta ke posisi saat ini setelah _currentPosition diatur
        _mapController.move(_currentPosition!, _currentZoom);
      }
    } catch (e) {
      print('Error: $e');
      // Menangani error di sini jika diperlukan
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 300,
        child: _currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: _currentPosition,
                  zoom: _currentZoom,
                  onPositionChanged: (position, hasGesture) {
                    setState(() {
                      _currentZoom = position.zoom!;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentPosition!,
                        width: 80.0,
                        height: 80.0,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 255, 247, 0),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: _currentPosition!,
                        color: const Color.fromARGB(255, 249, 249, 249)
                            .withOpacity(0.3),
                        borderStrokeWidth: 2.0,
                        useRadiusInMeter: true,
                        radius: _radius, // Radius dalam meter
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
