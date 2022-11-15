// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';
import '../../core/page_vm.dart';

/// 还在设计中。。。。
class ECHasSectionRandPage extends GetView<ECHasSectionRandPageVM> {
  const ECHasSectionRandPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.parameters["title"] ?? ""),
        ),
        body: GetBuilder<ECHasSectionRandPageVM>(
            builder: (e) => AdapterListViewBuilder.builder(controller.adapter,
                    reloadCall: () {
                  controller.update();
                })));
  }
}

class ECHasSectionRandPageVM extends GetxController with ECPageVM {}
