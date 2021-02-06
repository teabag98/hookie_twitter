import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/network/api_service.dart';
import 'package:hookie_twitter/src/screens/home/menu/drawer.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {

  final Function(String) callback;
  final Color color;
  HomeScreen({this.color = Colors.black, this.callback});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


// var uuid = Uuid();

class _HomeScreenState extends State<HomeScreen> {
  static var user = User();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static Logger log = sl.get<Logger>();
  // instantiate shared prefs
  static SharedPrefsUtil db = sl.get<SharedPrefsUtil>();

  BitmapDescriptor locIcon;

  ApiService apiService;

  var markerIdVal = user.id.toString();
 static  MarkerId markerId ;


@override
void initState(){
  super.initState();
  apiService = ApiService();
  location = new Location();
  location.onLocationChanged.listen((LocationData liveLocation) {
      currentLocation = liveLocation;

      markerId = MarkerId(markerIdVal);
      db.getUser().then((value) => user = value);
      bool _state;
      db.get('status').then((value) => value = _state);

       apiService.updateLocation(state:_state ,latitude: liveLocation.latitude.toString(),longitude: liveLocation.longitude.toString());
        updatePinOnMap();
      _addPinOnMap();
        log.d('location' ,liveLocation.longitude);

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
  var pinPosition = LatLng(double.parse(user.latitude) , double.parse(user.longitude ));

  setState(() {
    CameraPosition cameraPosition = CameraPosition(
        target:pinPosition,
        tilt: 20.4444444444,
        bearing: 192.83339,
        zoom:17.159,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    markers.removeWhere((key, value) => false);
    _addPinOnMap();
  });

}

// showPinOnMap(){
//   var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
//   markers.putIfAbsent(markerId ,Marker(
//     markerId:MarkerId(uuid.toStlocationring()),
//     position: pinPosition,
//     icon:locIcon
//   ));
// }

  void _addPinOnMap() {

    var latitude = double.parse(user.latitude);
    var longitude = double.parse(user.longitude);

    // creating a new MARKER for each near hookie
    final Marker marker = Marker(
      markerId: markerId,
      icon: locIcon,
      position: LatLng(
        latitude  + sin(user.id * pi / 6.0) / 20.0,
        longitude + cos(user.id * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: user.username, snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);

      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
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


  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
      return GoogleMap(
        myLocationEnabled: true, // For showing your current location on the map with a blue dot.
        markers: Set<Marker>.of(markers.values),
        compassEnabled: false,
        initialCameraPosition: _innitialLoc,
        mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true, // Whether to show zoom controls (only applicable for Android).
          myLocationButtonEnabled: false, // T
        onCameraMove: (CameraPosition cameraPosition){
          return cameraPosition.zoom;
        },
        onMapCreated: (GoogleMapController controller) {
          _controler.complete(controller);
          _addPinOnMap();
        },
        onTap: (_){},
        onLongPress: (_){},
        
      );
  }
}