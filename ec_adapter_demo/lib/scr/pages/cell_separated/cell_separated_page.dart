import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';
import '../../core/page_vm.dart';
import '../../widgets/custer_cell.dart';
import '../../widgets/separated.dart';

/// 包含cell和separad
/// 包含自定义的分割线
class ECCellSeparamtedPage extends GetView<ECCellSeparamtedPageVM> {
   ECCellSeparamtedPage({Key? key}) : super(key: key);
  Stream<String> s = Stream.value("123");
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
            Text(Get.parameters["title"] ?? ""),
        ),
        body: GetBuilder<ECCellSeparamtedPageVM>(
            builder: (e) => AdapterListViewBuilder.builder(
                    controller.adapter, 
                    padding: EdgeInsets.all(12),
                    reloadCall: () {
                  controller.update();
                })));
  }
}

class ECCellSeparamtedPageVM extends GetxController with ECPageVM {
  late ListViewBaseSectionItem section = ListViewBaseSectionItem();

  @override
  void onInit() {
    super.onInit();

    List<ECCusterCellVM> list = [0, 1, 3, 4, 5, 6].map((e) {
      ECCusterCellVM vm = ECCusterCellVM("标题$e", "点击cell可以删除：$e");
      vm.separated = 5.0 * e;
      if (e == 4) {
        // 自定义一个separated
        vm.separatedBuilder = () => ECCusterSeparated();
      }
      return vm;
    }).toList();

    section.addItems(list);
    adapter.reload(sections: [section]);
  }
}
