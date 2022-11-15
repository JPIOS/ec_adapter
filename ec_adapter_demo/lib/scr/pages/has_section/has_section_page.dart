import 'package:ec_adapter_demo/scr/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';
import 'has_section_page_vm.dart';

/// 包含section分组
/// 包含cell和separad
/// 包含section的头部和尾部
class ECHasSectionPage extends GetView<ECHasSectionPageVM> {
  const ECHasSectionPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.parameters["title"] ?? ""),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("中间白色的是Separated"),
            Expanded(
              child: GetBuilder<ECHasSectionPageVM>(
                  builder: (e) => AdapterListViewBuilder.builder(
                          controller.adapter, reloadCall: () {
                        controller.update();
                      })),
            )
          ],
        ));
  }
}