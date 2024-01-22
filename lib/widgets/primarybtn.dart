import 'package:big_dog_app/helpers/loader-snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final text;
  final onTap;
  PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final loadingcontroller = Get.put(LoadingController());

    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(370.w, 60.h),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
      ),
      onPressed: onTap,
      child: Obx(
        () => loadingcontroller.loadingon == true
            ? SizedBox(
                width: 25.w,
                height: 25.w,
                child: CircularProgressIndicator(color: Colors.white))
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
      ),
    );
  }
}
