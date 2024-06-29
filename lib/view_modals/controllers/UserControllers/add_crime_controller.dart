import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../constants/contantData.dart';

class AddCrimeController extends GetxController
{

  static AddCrimeController get instance => Get.find();

  final descriptionController = TextEditingController().obs;
  RxBool isAnonymous = false.obs;

  RxString selectedImage = "".obs;
  RxString selectedVideo = "".obs;

  final placesIsLoad = false.obs;
  Rx<LatLng> latLngValue = LatLng(0, 0).obs;


  Future<Map> getPlaces({required String text}) async {
    var data = await http.get(Uri.parse('https://map-places.p.rapidapi.com/autocomplete/json?input=$text'),
      headers: {
        'X-RapidAPI-Key': ConstantData.xRapidApiKey,
        'X-RapidAPI-Host': ConstantData.xRapidApiHost
      },
    );
    Map map = jsonDecode(data.body);
    return map;
  }

  Future<Map> getPlaceDetails({required String placeId}) async {
    var data = await http.get(Uri.parse('https://map-places.p.rapidapi.com/details/json?place_id=$placeId'),
      headers: {
        'X-RapidAPI-Key': ConstantData.xRapidApiKey,
        'X-RapidAPI-Host': ConstantData.xRapidApiHost
      },
    );
    Map map = jsonDecode(data.body);
    return map;
  }

}