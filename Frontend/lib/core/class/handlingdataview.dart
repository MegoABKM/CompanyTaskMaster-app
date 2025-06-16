import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/imageasset.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_button_auth.dart';

class Handlingdataview extends StatelessWidget {
  final StatusRequest? statusRequest;
  final Widget widget;
  const Handlingdataview(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LottieBuilder.asset(
                  AppImageAsset.loading,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Loading...")
            ],
          )
        : statusRequest == StatusRequest.serverfailure
            ? Center(child: Lottie.asset(AppImageAsset.servererror))
            : statusRequest == StatusRequest.offlinefailure
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        AppImageAsset.offline,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // CustomButtonAuth(
                      //   textbutton: "Refresh",
                      //   onPressed: () async {
                      //     if (await checkInternet()) {
                      //       Get.offAllNamed('/');
                      //     } else {
                      //       Get.defaultDialog(
                      //           title: "warning",
                      //           middleText: "No Internet Connection");
                      //     }
                      //   },
                      // )
                    ],
                  ))
                : statusRequest == StatusRequest.serverExeption
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(40),
                            child: Lottie.asset(
                              AppImageAsset.servererror,
                            ),
                          ),
                          const Text("No Response From Server "),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtonAuth(
                            textbutton: "Refresh",
                            onPressed: () async {
                              Get.offAllNamed(AppRoute.home);
                            },
                          )
                        ],
                      ))
                    // : statusRequest == StatusRequest.failure
                    //     ? Column(
                    //         children: [
                    //           Center(
                    //               child: Lottie.asset(AppImageAsset.nodata,
                    //                   fit: BoxFit.cover)),
                    //           const SizedBox(
                    //             height: 10,
                    //           ),
                    //           const Text("No Data")
                    //         ],
                    //       )
                    : widget;
  }
}
