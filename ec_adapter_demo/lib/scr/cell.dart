import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeCell extends StatelessWidget with ListViewCellType<HomeCellVM> {
  HomeCell({super.key});

  @override
  didSelect(HomeCellVM vm) {
    // 这里就是点击cell的效果
    debugPrint(vm.name);
  }

  @override
  Widget build(BuildContext context) {
    // 这里就拿到cellVM了
    return Container(padding: const EdgeInsets.all(10), child: Text(item.name));
  }
}

class HomeCellVM with ListViewItemType {
  final String name;
  HomeCellVM(this.name);

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => HomeCell();
}
