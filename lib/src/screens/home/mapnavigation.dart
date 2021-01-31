import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/screens/home/menu/drawer.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) callback;
  final Color color;
  HomeScreen({this.color = Colors.black, this.callback});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


var uuid = Uuid();

class _HomeScreenState extends State<HomeScreen> {
  static User user = User();
  BitmapDescriptor locIcon;


@override
void initState(){
  super.initState();
  location = new Location();
  location.onLocationChanged.listen((LocationData liveLocation) {
      currentLocation = liveLocation;


        updatePinOnMap();


     
  });
  BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10,10)), 'assets/images/my_locaion_pin.png')
  .then((value) {locIcon=value;});

}


@override
void dispose(){
  super.dispose();
}

void updatePinOnMap()async{
  final GoogleMapController controller = await _controler.future;
  var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

  setState(() {
    CameraPosition cameraPosition = CameraPosition(
        target:pinPosition,
        tilt: 20.4444444444,
        bearing: 192.83339,
        zoom:17.159,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    _marker.removeWhere((element) => element.markerId.value == uuid.toString());
    _marker.add(Marker(
        markerId: MarkerId(uuid.toString()),
        position: pinPosition,
        icon: locIcon ));
  });

}

showPinOnMap(){
  var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
  _marker.add(Marker(
    markerId:MarkerId(uuid.toString()),
    position: pinPosition,
    icon:locIcon
  ));
}


  var windowWidth;
  var windowHeight;
  static CameraPosition _innitialLoc = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.273543, 36.815028),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  LocationData currentLocation;
  Location location ;

   Completer<GoogleMapController> _controler = new Completer();
  Set<Marker> _marker = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
      return GoogleMap(
        myLocationEnabled: true, // For showing your current location on the map with a blue dot.
        markers: _marker,
        compassEnabled: false,
        initialCameraPosition: _innitialLoc,
        mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true, // Whether to show zoom controls (only applicable for Android).
          myLocationButtonEnabled: false, // T
        onMapCreated: (GoogleMapController controller) {
          _controler.complete(controller);
          showPinOnMap();
        },
        onTap: (_){},
        onLongPress: (_){},


      );
  }
}