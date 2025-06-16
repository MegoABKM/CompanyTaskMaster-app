import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/homemanager/requestjoin_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class RequestJoinPage extends StatelessWidget {
  const RequestJoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequestJoinController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "248".tr, // Employee Join Requests
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<RequestJoinController>(
        builder: (controller) {
          if (controller.joinRequests.isEmpty) {
            return Center(
              child: Text(
                "249".tr, // No join requests available.
                style: TextStyle(fontSize: context.scaleConfig.scaleText(16)),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(context.scaleConfig.scale(10)),
            itemCount: controller.joinRequests.length,
            itemBuilder: (context, index) {
              final request = controller.joinRequests[index];
              return Card(
                margin: EdgeInsets.symmetric(
                    vertical: context.scaleConfig.scale(8)),
                elevation: context.scaleConfig.scale(3),
                child: Padding(
                  padding: EdgeInsets.all(context.scaleConfig.scale(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            request.usersName != null &&
                                    request.usersName!.isNotEmpty
                                ? request.usersName![0].toUpperCase()
                                : 'N/A',
                            style: TextStyle(
                              fontSize: context.scaleConfig.scaleText(24),
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: context.scaleConfig.scale(8)),
                          Text(
                            "${request.usersName ?? 'N/A'}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.scaleConfig.scaleText(22),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.scaleConfig.scale(4)),
                      Text(
                        "250".tr +
                            " ${request.usersEmail ?? 'N/A'}", // User Email:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(16)),
                      ),
                      SizedBox(height: context.scaleConfig.scale(4)),
                      Text(
                        "251".tr +
                            " ${request.usersPhone ?? 'N/A'}", // User Phone:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(16)),
                      ),
                      SizedBox(height: context.scaleConfig.scale(4)),
                      Divider(height: context.scaleConfig.scale(10)),
                      SizedBox(height: context.scaleConfig.scale(8)),
                      Text(
                        "252".tr +
                            " ${request.companyName ?? 'N/A'}", // Company Name:
                        style: TextStyle(
                          fontSize: context.scaleConfig.scaleText(22),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.scaleConfig.scale(4)),
                      Text(
                        "253".tr +
                            " ${request.companyNickID ?? 'N/A'}", // Company NickID:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(16)),
                      ),
                      SizedBox(height: context.scaleConfig.scale(4)),
                      Text(
                        "254".tr +
                            " ${request.companyWorkes ?? 'N/A'}", // Company Workers:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(16)),
                      ),
                      SizedBox(height: context.scaleConfig.scale(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "255".tr +
                                  " ${request.daterequest ?? 'N/A'}", // Date Request:
                              style: TextStyle(
                                fontSize: context.scaleConfig.scaleText(14),
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.accpetRequest(
                                      request.employeeCompanyId!.toString(),
                                      request.userId!.toString());
                                },
                                icon: Icon(Icons.check,
                                    color: Colors.green,
                                    size: context.scaleConfig.scale(24)),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.rejectRequest(
                                      request.employeeCompanyId!.toString(),
                                      request.userId!.toString());
                                },
                                icon: Icon(Icons.close,
                                    color: Colors.red,
                                    size: context.scaleConfig.scale(24)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
