import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';

class ECCusterCell extends StatelessWidget
    with ListViewCellType<ECCusterCellVM> {
  ECCusterCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title),
              Text(item.detail),
            ],
          ),
          Row(
            children: [
              Obx(
                () => Text("${item.count.value}"),
              ),
              IconButton(
                onPressed: () {
                  item.count + 1;
                },
                icon: const Icon(Icons.add),
                iconSize: 18,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  didSelectMoreItem<S extends ListViewSectionItemType, P extends Object>(
      ECCusterCellVM item, S sectionItem, P? pageItem) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 18),
      contentPadding: const EdgeInsets.only(top: 10,left: 18,right: 18,bottom: 18),
      title: "删除这个cell",
      middleText: "middler是啥",
      textCustom: "点我干啥？${item.title}-${item.detail}",
      content: Text("我的内容是？${item.title}-${item.detail}"),
      onConfirm: () {
        sectionItem.remove(item);
        sectionItem.reloadList!();
        Get.back();
      },
    );
  }

  @override
  didSelect(ECCusterCellVM t) {}
}

class ECCusterCellVM with ListViewItemType {
  final String title;
  final String detail;
  final RxInt count = 0.obs;
  ECCusterCellVM(this.title, this.detail);

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => ECCusterCell();
}
