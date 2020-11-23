import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin_keja/models/locations.dart' as locations;

class Gmap extends StatefulWidget {
  var latitude, longitude;
  Gmap({this.latitude, this.longitude});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Gmap> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId('home'),
        position: LatLng(double.parse(widget.latitude),
        double.parse( widget.longitude)),
        infoWindow: InfoWindow(
          title: 'Gwakairu',
          snippet: 'off KU',
        ),
      );
      _markers['home'] = marker;
    });
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Office Locations'),
          backgroundColor: LightColors.kDarkYellow,
        ),
        body: Container(
          height: 200,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0),
              zoom: 2,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
    );
  }
}
