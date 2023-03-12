import 'package:location/location.dart';
import 'package:flutter/material.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({Key? key}) : super(key: key);

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {

  Location location = new Location();
  late LocationData _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;


  //function to get users current location
  Future<dynamic> getUserLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied)
      {
        _permissionGranted = await location.requestPermission();
      }

    _locationData = await location.getLocation();
  }


  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
