import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oddo/constants/contantData.dart';
import 'package:oddo/modal/crimes_modal.dart';
import 'package:oddo/res/utils/utils.dart';
import 'package:oddo/view_modals/controllers/UserControllers/view_crimes_controller.dart';

import '../../../widgets/primary_button.dart';

class ViewCrimeReportScreen extends StatefulWidget {
  const ViewCrimeReportScreen({super.key});

  @override
  State<ViewCrimeReportScreen> createState() => _ViewCrimeReportScreenState();
}

class _ViewCrimeReportScreenState extends State<ViewCrimeReportScreen> {

  final controller = Get.put(ViewCrimesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.crimesModal.value = RxList<CrimesModal>();
      controller.getCrimes(context: context);
      controller.scrollController.addListener(loadMoreData);
    },);
  }

  void loadMoreData() {
    if(controller.scrollController.position.pixels == controller.scrollController.position.maxScrollExtent && controller.crimesModal.value.length < controller.total.value){
      if(mounted)
      {
        controller.getCrimes(context: context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.disposeVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryTextAppBar(title: "View Added Crimes"),
      body: RefreshIndicator(
        onRefresh: () {
          controller.refreshData(context: context);
          return Future.value();
        },
        child: Obx(
              () => Padding(
            padding: EdgeInsets.symmetric(horizontal: ConstantData.defaultPadding),
            child: controller.crimesModal.isNotEmpty
                ? Column(
              children: [
                Row(
                  children: [
                    dataAnalysisContainer(
                      imageUrl: AppIcons.sortIcon,
                      text: "SORT",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return sortingDialog(
                              onTap1: () {
                                controller.sortingField.value='date DESC';
                                controller.getSortedFilteredProducts();
                                Get.back();
                              },
                              onTap2: () {
                                controller.sortingField.value='price';
                                controller.getSortedFilteredProducts();
                                Get.back();
                              },
                              onTap3: () {
                                controller.sortingField.value='price DESC';
                                controller.getSortedFilteredProducts();
                                Get.back();
                              },
                              context: context,
                            );
                          },
                        );
                      },
                    ),
                    addHorizontalSpace(width: 8.w),
                    dataAnalysisContainer(
                      imageUrl: AppIcons.filterIcon,
                      text: "FILTER",
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 27.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Price Range", style: materialTextStyle1),
                                  Text("₹0 - ₹500", style: materialTextStyle2,),
                                  Row(
                                    children: [
                                      Text("₹1", style: materialTextStyle2,),
                                      Flexible(
                                        child: Material(
                                          child: Obx(
                                                ()=> RangeSlider(
                                              values: controller.rangeValues.value,
                                              min: 1,
                                              max: 500,
                                              divisions: 499,
                                              activeColor: AppColors.brownColor,
                                              inactiveColor: AppColors.shade400GreyColor,
                                              labels: RangeLabels(
                                                controller.rangeValues.value.start.round().toString(),
                                                controller.rangeValues.value.end.round().toString(),
                                              ),
                                              onChanged: (RangeValues values) {
                                                controller.rangeValues.value = values;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text("₹500", style: materialTextStyle2,),
                                    ],
                                  ),
                                  if(ConstantData.selectedCategory == ConstantData.categories[0])
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        addVerticalSpace(height: 15.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Type", style: materialTextStyle3,),
                                          ],
                                        ),
                                        addVerticalSpace(height: 12.h),
                                        Column(
                                          children: ConstantData.mangalsutraFilers.map((e) {
                                            return Obx(
                                                  ()=> filterCategoryCard(text: e, isSelected: e==controller.selectedSubCategory.value, onTap: () {
                                                controller.selectedSubCategory.value = e.toString();
                                              },),
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: PrimaryButton(
                                          height: 40.h,
                                          fontSize: 16.sp,
                                          backgroundColor: Colors.white,
                                          fontColor: AppColors.blackColor,
                                          text: "Clear",
                                          onPressed: () {
                                            controller.clearFilters();
                                          },
                                        ),
                                      ),
                                      addHorizontalSpace(width: 8.w),
                                      Flexible(
                                        child: PrimaryButton(
                                          height: 40.h,
                                          fontSize: 16.sp,
                                          text: "Apply Filter",
                                          onPressed: () {
                                            controller.getSortedFilteredProducts();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Obx(
                      () => controller.crimesModal.isNotEmpty
                      ? (controller.crimesModal[0].itemName != null
                      ? Flexible(
                    child: GridView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount:
                      controller.crimesModal.length,
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 205.h,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 8.h),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Hero(
                                    tag: controller.crimesModal[index].imageUrls![0],
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  controller.crimesModal[index].imageUrls![0]
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(height: 3.h),
                                Text(
                                    "CODE : ${controller.crimesModal[index].code!}",
                                    style: black12),
                                Text(
                                    "₹ ${controller.crimesModal[index].price!}",
                                    style: black12),
                                if (index ==
                                    controller.crimesModal.length -
                                        1 ||
                                    index ==
                                        controller.crimesModal.length -
                                            2)
                                  addVerticalSpace(height: 10.h),
                                if (index ==
                                    controller.crimesModal.length -
                                        1 ||
                                    index ==
                                        controller.crimesModal.length -
                                            2)
                                  Obx(() => controller
                                      .isLoading.value
                                      ? Padding(
                                    padding:
                                    EdgeInsets.symmetric(
                                        vertical: 20.h),
                                    child: SpinKitCircle(
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  )
                                      : SizedBox()),
                              ],
                            ),
                            if(controller.crimesModal[index].isOutOfStock=="true")
                              Positioned(
                                child: Image.asset(AppIcons.outOfStockIcon, height: 35.h,),
                              )
                          ],
                        );
                      },
                    ),
                  )
                      : Flexible(child: noDataWidget(message: Strings.noProductAvailable,)))
                      : SpinKitCircle(
                    color: Colors.black,
                    size: 30,
                  ),
                )
              ],
            )
                : SpinKitFadingCircle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
