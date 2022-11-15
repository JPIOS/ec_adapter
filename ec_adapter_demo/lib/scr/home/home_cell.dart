import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';

class HomeCell extends StatelessWidget with ListViewCellType<HomeCellVM> {
  HomeCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            item.title,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  didSelect(item) {
    Get.toNamed(item.routerName, parameters: {"title": item.title});
  }
}

/// cellVM
class HomeCellVM with ListViewItemType {
  final String title;
  final String routerName;
  HomeCellVM(this.title, this.routerName);

  @override
  ListViewCellType<ListViewItemType> cellBuilder() {
    return HomeCell();
  }
}
