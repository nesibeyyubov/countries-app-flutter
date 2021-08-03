import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryMapScreen extends StatefulWidget {
  static const routeName = "countries_map";

  @override
  _CountryMapScreenState createState() => _CountryMapScreenState();
}

class _CountryMapScreenState extends State<CountryMapScreen> {
  Completer<GoogleMapController> _completer = Completer();
  MapType mapType = MapType.normal;
  Map<MarkerId, Marker> markers = {};
  bool _isInit = true;

  void onMapTypeChanged(MapType newMapType) {
    setState(() {
      mapType = newMapType;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_isInit){
      List<double> latlng =
      ModalRoute.of(context)?.settings.arguments as List<double>;
      final markerId = MarkerId("country_marker");
      final marker = Marker(
          markerId: markerId,
          onTap: () {},
          position: LatLng(latlng[0], latlng[1]));

      markers[markerId] = marker;
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    List<double> latlng =
        ModalRoute.of(context)?.settings.arguments as List<double>;
    CameraPosition _initialCameraPosition =
        CameraPosition(target: LatLng(latlng[0], latlng[1]), zoom: 6);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              color: Theme.of(context).primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterChip(
                    backgroundColor: mapType == MapType.normal
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1)),
                    labelStyle: TextStyle(
                        color: mapType == MapType.normal
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    label: Text("Normal"),
                    onSelected: (_) => onMapTypeChanged(MapType.normal),
                  ),
                  FilterChip(
                    backgroundColor: mapType == MapType.satellite
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1)),
                    labelStyle: TextStyle(
                        color: mapType == MapType.satellite
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    label: Text("Satellite"),
                    onSelected: (_) => onMapTypeChanged(MapType.satellite),
                  ),
                  FilterChip(
                    backgroundColor: mapType == MapType.terrain
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1)),
                    labelStyle: TextStyle(
                        color: mapType == MapType.terrain
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    label: Text("Terrain"),
                    onSelected: (_) => onMapTypeChanged(MapType.terrain),
                  ),
                  FilterChip(
                    backgroundColor: mapType == MapType.hybrid
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1)),
                    labelStyle: TextStyle(
                        color: mapType == MapType.hybrid
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    label: Text("Hybrid"),
                    onSelected: (_) => onMapTypeChanged(MapType.hybrid),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                markers: Set<Marker>.of(markers.values),
                mapType: mapType,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) {
                  _completer.complete(controller);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
