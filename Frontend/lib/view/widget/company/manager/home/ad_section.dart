import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/imageasset.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class AdSectionManager extends StatelessWidget {
  const AdSectionManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.scaleConfig.scale(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(context.scaleConfig.scale(10)),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(15)),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(context.scaleConfig.scale(10)),
                    child: Image.asset(
                      AppImageAsset.google,
                      width: context.scaleConfig.scale(80),
                      height: context.scaleConfig.scale(80),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: context.scaleConfig.scale(10)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "80".tr,
                          style: context.appTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: context.scaleConfig.scaleText(20),
                          ),
                        ),
                        SizedBox(height: context.scaleConfig.scale(5)),
                        Text(
                          "81".tr,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: context.scaleConfig.scaleText(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: context.scaleConfig.scale(20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
