import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_urls.dart';
import '../../../constants/strings.dart';
import '../../../data/network/network_api_services.dart';
import '../../../modal/crimes_modal.dart';
import '../../../res/utils/utils.dart';

class ViewCrimesController extends GetxController{

  final searchController = TextEditingController().obs;
  final ScrollController scrollController = ScrollController();
  RxList<CrimesModal> crimesModal = <CrimesModal>[].obs;
  RxInt total = 0.obs;

  final rangeValues = RangeValues(1, 500).obs;

  RxString selectedSubCategory = "".obs;

  RxBool isLoading = false.obs;

  RxString sortingField = "".obs;
  RxString filterType = "".obs;

  Future<void> getCrimes({required BuildContext context}) async {
    isLoading.value=true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    NetworkApiServices().postApi("${AppUrls.baseUrl}${AppUrls.getCrimes}", jsonEncode({
      "token": token
    })).then((value) {
      isLoading.value=false;
      if(value['status']==403)
      {
        CrimesModal modal = CrimesModal();
        crimesModal.add(modal);
      }
      else
      {
        if(value.containsKey(Strings.noInternetKey))
        {
          showSnackBar(message: "No Internet, Please connect to the internet.", context: context);
          CrimesModal modal = CrimesModal();
          crimesModal.add(modal);
        }
        else{
          if(value["status"]==1)
          {
            total.value = value['total'];
            final List data = value['data'];
            final List<CrimesModal> products = data.map((e) => CrimesModal.fromJson(e)).toList();
            crimesModal.addAll(products);
          }
          else
          {
            CrimesModal modal = CrimesModal();
            crimesModal.add(modal);
          }
        }
      }
    });
  }

  Future<void> getSortedFilteredProducts() async {
    crimesModal.value = RxList<CrimesModal>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";
    NetworkApiServices().postApi("${AppUrls.baseUrl}${AppUrls.getCrimes}", jsonEncode({
      "token": token
    })).then((value) {
      if(value['status']==403)
      {
        CrimesModal modal = CrimesModal();
        crimesModal.add(modal);
      }
      else{
        if(value['status']==403) {
          CrimesModal modal = CrimesModal();
          crimesModal.add(modal);
        }
        else {
          if(value["status"]==1) {
            total.value = value['total'];
            final List data = value['data'];
            final List<CrimesModal> products = data.map((e) => CrimesModal.fromJson(e)).toList();
            crimesModal.addAll(products);
          }
          else {
            CrimesModal modal = CrimesModal();
            crimesModal.add(modal);
          }
        }
      }
    });
  }

  void clearFilters() {
    rangeValues.value = RangeValues(1, 500);
    selectedSubCategory.value = "";
  }

  void refreshData({required BuildContext context}) {
    crimesModal.value = RxList<CrimesModal>();
    getCrimes(context: context);
  }

  void disposeVariables(){
    crimesModal.value = RxList<CrimesModal>();
    total.value = 0;
    sortingField.value="";
    filterType.value="";
    rangeValues.value = RangeValues(1, 500);
  }

}