import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/imageasset.dart';

class HandlingDataAuthview extends StatelessWidget {
  final StatusRequest? statusRequest;
  final Widget widget;
  const HandlingDataAuthview(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LottieBuilder.asset(
                  AppImageAsset.loading2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Loading...")
            ],
          )
        : statusRequest == StatusRequest.serverfailure
            ? const Center(child: Text("Server Error")
                // Lottie.asset(AppImageAsset.servererror)
                )
            : statusRequest == StatusRequest.offlinefailure
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Offline"),
                      // Lottie.asset(
                      //   AppImageAsset.offline,
                      // ),
                      SizedBox(
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
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: const Center(
                                // child: Lottie.asset(AppImageAsset.servererror,
                                //     fit: BoxFit.cover)
                                ),
                          ),
                          const Text("Server Error , Page Not Found")
                        ],
                      )
                    : widget;
  }
}
