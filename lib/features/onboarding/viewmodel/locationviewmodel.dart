import 'dart:io';

import 'package:big_dog_app/features/onboarding/view/home.dart';
import 'package:big_dog_app/features/onboarding/viewmodel/authviewmodel.dart';
import 'package:big_dog_app/helpers/loader-snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LocationViewModel extends GetxController {
  LatLng? currentPosition;
  bool isLoadingLocation = true;
  late GoogleMapController mapController;

  late BitmapDescriptor customIcon;

  List chargingtype = ["J1772", "CSS", "CHAdeMo", "NACS", "Tesla", "Other"];
  TextEditingController describeProblem = TextEditingController();

  int SelectedChargingType = 0;
  late IO.Socket socket;
  String requestID = "";
  final loadingcontroller = Get.put(LoadingController());

// make sure to initialize before map loading

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(20, 20)), 'assets/icons/pin.png')
        .then((d) {
      customIcon = d;
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);
    currentPosition = location;
    isLoadingLocation = false;
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle('''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]''');
  }

  changeChargingType(value) {
    SelectedChargingType = value;
    update();
  }

  submit(context) {
    loadingcontroller.loadingswitch();
    final usercontroller = Get.put(AuthViewModel());

    print("cc");
    Map<String, dynamic> headers = {
      'Authorization': usercontroller.userAuthToken,
      'refreshToken': usercontroller.userRefreshToken,
      "deviceToken": "none",
      "deviceType": Platform.isAndroid ? "android" : "ios"
    };

    socket = IO.io("wss://bigdog.thecloudlearner.com/", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'force new connection': true,
      'extraHeaders': headers,
    });

    socket.connect();

    socket.onConnect((_) {
      print('connect');
    });
    socket.on('requestStatusChanged', (data) {
      print("requestStatusChanged");
      print(data);
      print(data['accepted']);
      if (data['accepted']) {
        socket.disconnect();
        Get.back();
        describeProblem.clear();
        LoaderService()
            .showSnackbar("Accepted", "You request has been accepted");
      } else {
        socket.disconnect();
        Get.back();
        describeProblem.clear();

        LoaderService()
            .showSnackbar("Rejected", "You request has been rejected");
      }
    });
    socket.on('createEmergencyRequestResponse', (data) {
      print("createEmergencyRequestResponse");
      print(data);
      if (data['success']) {
        loadingcontroller.loadingswitch();
        Get.back();
        requestID = data['requestId'];
        describeProblem.clear();

        waitCancelPopup(context);
      }
    });
    socket.on('cancelEmergencyRequestResponse', (data) {
      print("cancelEmergencyRequestResponse");
      print(data);
      loadingcontroller.loadingswitch();
      Get.back();
    });

    socket.on('connected', (data) {
      print("connected");
      print(data);
      if (data['success']) {
        socket.emit('emergencyRequest', {
          "lat": currentPosition!.latitude,
          "long": currentPosition!.longitude,
          "chargingType": chargingtype[SelectedChargingType],
          "reason": describeProblem.text.toString()
        });
        // waitCancelPopup(context);
      }
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  cancelrequest(context) {
    loadingcontroller.loadingswitch();

    socket.emit(
        'cancelEmergencyRequest', {"requestId": requestID, "reason": "none"});
  }
}
