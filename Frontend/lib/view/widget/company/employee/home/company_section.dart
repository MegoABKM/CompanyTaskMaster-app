import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/employeehome_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class CompanySection extends GetView<EmployeehomeController> {
  const CompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
      ),
      itemCount: controller.companyList.length,
      itemBuilder: (context, index) {
        var company = controller.companyList[index];
        return GestureDetector(
          onTap: () => controller.goToWorkSpaceEmployee(company.companyId),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(15))),
            elevation: context.scaleConfig.scale(5),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(context.scaleConfig.scale(15)),
                  child: Image.network(
                    controller.getCompanyImageUrl(company.companyImage ?? ''),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(context.scaleConfig.scale(15)),
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.scaleConfig.scale(15),
                        horizontal: context.scaleConfig.scale(10)),
                    child: Text(
                      company.companyName ??
                          '173'.tr, // No name available -> No Title
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: context.scaleConfig.scaleText(20),
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  bottom: context.scaleConfig.scale(10),
                  right: context.scaleConfig.scale(10),
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.goToCompanyDetaislEmployee(company),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              context.scaleConfig.scale(8))),
                    ),
                    child: Text(
                      "82".tr, // View Details
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: context.scaleConfig.scaleText(14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
