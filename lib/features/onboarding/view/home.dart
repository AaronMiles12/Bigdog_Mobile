import 'package:big_dog_app/features/onboarding/view/selection.dart';
import 'package:big_dog_app/features/onboarding/viewmodel/locationviewmodel.dart';
import 'package:big_dog_app/widgets/customtextfield.dart';
import 'package:big_dog_app/widgets/primarybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(LocationViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            actions: [
              GestureDetector(
                onTap: () async {
                  final storage = new FlutterSecureStorage();
                  await storage.deleteAll();
                  Get.offAll(() => LoginSelection());
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              )
            ],
            centerTitle: true,
            title: Text("Home",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
          ),
          body: GetBuilder<LocationViewModel>(
            builder: (_) => controller.isLoadingLocation
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GoogleMap(
                        onMapCreated: controller.onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: controller.currentPosition!,
                          zoom: 16.0,
                        ),
                        markers: Set<Marker>.of(
                          <Marker>[
                            Marker(
                                markerId: MarkerId("currentLocation"),
                                position: controller.currentPosition!,
                                // icon: controller.customIcon,
                                draggable: true,
                                onDragEnd: ((newPosition) {
                                  controller.currentPosition = LatLng(
                                      newPosition.latitude,
                                      newPosition.longitude);
                                  print(controller.currentPosition);
                                })),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: PrimaryButton(
                          onTap: () {
                            SearchFilterpopup(context);
                          },
                          text: "Emergency Request",
                        ),
                      )
                    ],
                  ),
          )),
    );
  }
}

SearchFilterpopup(context) {
  final controller = Get.put(LocationViewModel());

  showModalBottomSheet<int>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 420.h,
          color: Theme.of(context).colorScheme.primary,
          width: double.infinity,
          child: Column(
            children: [
              15.verticalSpace,
              Container(
                height: 5.h,
                width: 231.w,
                decoration: BoxDecoration(
                    color: Color(0xff6F7B8F),
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
              ),
              15.verticalSpace,
              Text("Search Filter",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Color(0xffE7ECF3))),
              25.verticalSpace,
              Container(
                width: 370.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Color(0xffC2CAD8)),
                child: Padding(
                  padding: EdgeInsets.all(13.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Charging Type",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                        5.verticalSpace,
                        SizedBox(
                          height: 60.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.chargingtype.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GetBuilder<LocationViewModel>(
                                  builder: (_) => GestureDetector(
                                        onTap: () {
                                          controller.changeChargingType(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 90.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.r)),
                                                color: index ==
                                                        controller
                                                            .SelectedChargingType
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : Color(0xff97A6C1)),
                                            child: Center(
                                              child: Text(
                                                controller.chargingtype[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color:
                                                            Color(0xffE7ECF3)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ),
                        5.verticalSpace,
                        RoundedTextFieldWithIcon(
                          isEnable: true,
                          hintText: 'Description of problem',
                          suffixIconPath: '',
                          prefixIconPath: '',
                          controller: controller.describeProblem,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'Required field';
                            }
                          },
                        ),
                      ]),
                ),
              ),
              20.verticalSpace,
              PrimaryButton(
                onTap: () {
                  controller.submit(context);
                },
                text: "Book",
              )
            ],
          ),
        ),
      );
    },
  );
}

waitCancelPopup(context) {
  final controller = Get.put(LocationViewModel());

  showModalBottomSheet<int>(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        height: 323.h,
        color: Theme.of(context).colorScheme.primary,
        width: double.infinity,
        child: Column(
          children: [
            15.verticalSpace,
            Container(
              height: 5.h,
              width: 231.w,
              decoration: BoxDecoration(
                  color: Color(0xff6F7B8F),
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
            ),
            15.verticalSpace,
            Text("Request",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xffE7ECF3))),
            25.verticalSpace,
            Image.asset(
              "assets/icons/wait.png",
              width: 114.w,
            ),
            20.verticalSpace,
            Text(
              "You request has been sent Please Wait...",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            20.verticalSpace,
            PrimaryButton(
              onTap: () {
                controller.cancelrequest(context);
              },
              text: "Cancel Request",
            )
          ],
        ),
      );
    },
  );
}

requestAcceptedPopup(BuildContext context) {
  final controller = Get.put(LocationViewModel());

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        height: 323.h,
        color: Theme.of(context).colorScheme.primary,
        width: double.infinity,
        child: Column(
          children: [
            15.verticalSpace,
            Container(
              height: 5.h,
              width: 231.w,
              decoration: BoxDecoration(
                  color: Color(0xff6F7B8F),
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
            ),
            15.verticalSpace,
            Text("Request",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xffE7ECF3))),
            25.verticalSpace,
            Image.asset(
              "assets/icons/accept.png",
              width: 114.w,
            ),
            20.verticalSpace,
            Text(
              "You request has been accepted",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            20.verticalSpace,
            PrimaryButton(
              onTap: () {
                Get.back();
              },
              text: "Continue",
            )
          ],
        ),
      );
    },
  );
}
