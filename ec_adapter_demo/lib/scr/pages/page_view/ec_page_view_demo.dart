import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ec_adapter/ec_adapter.dart';

class ECPageViewDemoPage extends StatefulWidget {
  const ECPageViewDemoPage({super.key});

  @override
  State<ECPageViewDemoPage> createState() => _ECPageViewDemoPageState();
}

class _ECPageViewDemoPageState extends State<ECPageViewDemoPage> {
  ListViewAdapter adpater = ListViewAdapter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<_PageViewCellVM> list = List.generate(10, (index) => index)
        .toList()
        .map((e) => _PageViewCellVM("测试 当前页面 $e"))
        .toList();
    adpater.reloadSingleCell(list);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('pageViewDemo'),
        ),
        body: AdapterListViewBuilder.pageBuilder(adpater, reloadCall: () {
          setState(() {});
        }));
  }
}

class _PageViewCell extends StatelessWidget
    with ListViewCellType<_PageViewCellVM> {
  _PageViewCell({super.key});

  @override
  didSelect(_PageViewCellVM t) {
    /// 这里就是点击cell的效果
    print("点击了cell");
  }

  @override
  Widget build(BuildContext context) {
    // 这里就拿到cellVM了
    return Container(child: Text(item.name));
  }
}

class _PageViewCellVM with ListViewItemType {
  final String name;
  _PageViewCellVM(this.name);

  @override
  ListViewCellType<ListViewItemType> cellBuilder() => _PageViewCell();
}
