import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';
import '../../core/page_vm.dart';
import '../../widgets/custer_cell.dart';

class ECOnlyCellPage extends GetView<ECOnlyCellPageVM> {
  const ECOnlyCellPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.parameters["title"] ?? ""),
      ),
      floatingActionButton: IconButton(
          onPressed: () => controller.addItem(),
          icon: const Icon(
            Icons.add,
            color: Colors.red,
          )),
      body: GetBuilder<ECOnlyCellPageVM>(
          builder: (e) => AdapterListViewBuilder.builder(controller.adapter,
                  reloadCall: () {
                controller.update();
              })),
    );
  }
}

class ECOnlyCellPageVM extends GetxController with ECPageVM {
  late ListViewBaseSectionItem section = ListViewBaseSectionItem();
  @override
  void onInit() {
    super.onInit();

    List<ECCusterCellVM> list =
        [0, 1].map((e) => ECCusterCellVM("标题$e", "点击cell可以删除：$e")).toList();

    section.addItems(list);
    adapter.reload(sections: [section]);
  }

  addItem() {
    section.add(ECCusterCellVM("标题-新曾", "详情-新曾的"));
    adapter.reload();
  }
}
