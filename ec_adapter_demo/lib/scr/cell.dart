import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeCell extends StatelessWidget with ListViewCellType<HomeCellVM> {
  HomeCell({super.key});

  @override
  didSelect(HomeCellVM item) {
    // 这里就是点击cell的效果
    debugPrint(item.name);
  }

  @override
  Widget build(BuildContext context) {
    // 这里就拿到 HomeCellVM 对象item
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.section,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(item.name),
          ],
        ));
  }
}

class HomeCellVM with ListViewItemType {
  final String name;
  final String section;
  HomeCellVM(this.section, this.name);

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => HomeCell();
}
