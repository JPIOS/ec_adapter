import 'package:ec_adapter_demo/scr/pages/has_section_separated/has_section_separated_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';

/// 包含section分组
/// 包含cell和separad
/// 包含section的头部和尾部
/// 包含自定义的分割线
class ECHasSectionSeparatedPage extends GetView<ECHasSectionSeparatedPageVM> {
  const ECHasSectionSeparatedPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.parameters["title"] ?? ""),
        ),
        body: GetBuilder<ECHasSectionSeparatedPageVM>(
            builder: (e) => AdapterListViewBuilder.builder(controller.adapter,
                    reloadCall: () {
                  controller.update();
                })));
  }
}
