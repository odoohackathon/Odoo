import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oddo/res/utils/utils.dart';
import 'package:oddo/view_modals/controllers/UserControllers/add_crime_controller.dart';
import 'package:oddo/widgets/primary_button.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {

  final controller = AddCrimeController.instance;

  List placesData=[];
  TextEditingController searchPlaceController = TextEditingController();
  bool isExpanded = false;
  bool showNoData = false;
  late GoogleMapController mapController;
  var uuid = const Uuid();
  String? sessionToken;
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 14);

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(21.1702, 72.8311),
      infoWindow: InfoWindow(title: "Center of Surat"),
    ),
  ];

  Future<Position> getUserCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime(2024),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        );
      } else {
        return await Geolocator.getCurrentPosition();
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              onMapCreated(controller);
            },
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            onTap: (argument) {
              _markers.clear();
              _markers.add(Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(argument.latitude, argument.longitude),
                  infoWindow: InfoWindow(title: "My Current Location")));
              mapController.animateCamera(CameraUpdate.newLatLng(
                  LatLng(argument.latitude, argument.longitude)));
              controller.latLngValue.value=LatLng(argument.latitude, argument.longitude);
              setState(() {});
            },
          ),
          Positioned(
            top: 60.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                      if(!isExpanded)
                        {
                          placesData=[];
                        }
                      else
                        {
                          showNoData=false;
                        }
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: isExpanded ? MediaQuery.of(context).size.width-40 : 200,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isExpanded)
                          Text(
                            'Search here...',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        if (isExpanded)
                          Expanded(
                            child: TextField(
                              controller: searchPlaceController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search here...',
                              ),
                            ),
                          ),
                        if(isExpanded)
                          Obx(
                            ()=> IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppColors.primaryGreenColor),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                    ))
                                ),
                                onPressed: () {
                                  controller.placesIsLoad.value=true;
                                  controller.getPlaces(text: searchPlaceController.text.trim()).then((value) {
                                    placesData=[];
                                    if(value['status']=="OK")
                                      {
                                        for(int i=0;i<value['predictions'].length;i++)
                                        {
                                          placesData.add({
                                            "name": value['predictions'][i]['description'],
                                            "place_id": value['predictions'][i]['place_id'],
                                          });
                                        }
                                        controller.placesIsLoad.value=false;
                                        setState(() {});
                                      }
                                    else
                                      {
                                        placesData=[];
                                        showNoData=true;
                                        controller.placesIsLoad.value=false;
                                        setState(() {});
                                      }
                                  });
                                }, icon: controller.placesIsLoad.value ? SizedBox(width: 15.w,height: 15.h,child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),):Icon(Icons.search)),
                          ),
                        if (isExpanded) Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isExpanded)
                  if(placesData.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: placesData.map((e) {
                          return placesAutoCompleteText(text: e['name'], placeId: e['place_id']);
                        }).toList(),
                      ),
                    ),
                if(isExpanded)
                  if(placesData.isEmpty)
                    if(showNoData)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text("No Data Available"),
                          ),
                        ),
                      )
              ],
            ),
          ),
          Positioned(
              bottom: 100,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  getUserCurrentLocation().then((value) async {
                    if (value.latitude == 0) {
                      showSnackBar(
                          message: "Please Allow Location Permission",
                          context: context);
                    } else {
                      _markers.clear();
                      _markers.add(Marker(
                          markerId: MarkerId("2"),
                          position: LatLng(value.latitude, value.longitude),
                          infoWindow:
                              InfoWindow(title: "My Current Location")));
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(value.latitude, value.longitude), 15));
                      controller.latLngValue.value=LatLng(value.latitude, value.longitude);
                      setState(() {});
                    }
                  });
                },
                child: Container(
                  height: 65.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.purple.shade100),
                  child: Icon(Icons.my_location, size: 30.w),
                ),
              )),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            left: 20.w,
            child: PrimaryButton(
              text: "Submit",
              onPressed: () {
                if(controller.latLngValue.value.latitude==0)
                  {
                    showSnackBar(message: "Select location by clicking on map at your address or current location", context: context);
                  }
                else
                  {
                    Get.back();
                  }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget placesAutoCompleteText({required String text, required String placeId}){
    return InkWell(
      onTap: () {
        controller.getPlaceDetails(placeId: placeId).then((value) {
          _markers.clear();
          _markers.add(Marker(
              markerId: MarkerId("2"),
              position: LatLng(value["result"]["geometry"]["location"]["lat"], value["result"]["geometry"]["location"]["lng"]),
              infoWindow: InfoWindow(title: "My Current Location")));
          mapController.animateCamera(CameraUpdate.newLatLng(
              LatLng(value["result"]["geometry"]["location"]["lat"], value["result"]["geometry"]["location"]["lng"])));
          controller.latLngValue.value=LatLng(value["result"]["geometry"]["location"]["lat"], value["result"]["geometry"]["location"]["lng"]);
          setState(() {
            isExpanded=false;
            placesData=[];
          });
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text ,textAlign: TextAlign.start,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(color: Colors.grey, height: 1,),
          )
        ],
      ),
    );
  }
}
