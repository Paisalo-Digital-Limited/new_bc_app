/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeVisitMapPage extends StatefulWidget {
  const HomeVisitMapPage({super.key});

  @override
  State<HomeVisitMapPage> createState() => _HomeVisitMapPageState();
}

class _HomeVisitMapPageState extends State<HomeVisitMapPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map with Text',
      home: MapWithTextPage(),
    );
  }
}
class MapWithTextPage extends StatefulWidget {
  @override
  _MapWithTextPageState createState() => _MapWithTextPageState();
}

class _MapWithTextPageState extends State<MapWithTextPage> {
  late GoogleMapController mapController;

  // Initial position for the map
  final LatLng _center = const LatLng(37.7749, -122.4194);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Text'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Text(
              'Additional Text Here',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
