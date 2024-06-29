import 'package:get/get.dart';
import 'package:oddo/constants/app_urls.dart';
import 'package:oddo/data/network/network_api_services.dart';

import '../../modal/crimes_modal.dart';

class CheckCreimesController extends GetxController
{

  getData(){
    NetworkApiServices().getApi(Uri.parse("${AppUrls.checkCrimes}")).then((value) {
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
    },);
  }

}