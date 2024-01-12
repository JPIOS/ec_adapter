# flutter适配器组建
### 说明主要是为了适配mvvm而存在，并需要遵守一下协议

#### 1 cell 中需要遵守 ListViewCellType

#### 2 cellVM 中需要遵守 ListViewItemType

#### 3 section 的 header 和 footer 需要遵循 ListViewHeaderFooterType

#### 4 sectionVM 需要遵守 ListViewSectionItemType

#### 5 通过 AdapterListViewBuilder.builder 创建 listView 并将 ListViewAdapter 实例对象传入其中

#### 6 刷新 
      - 不需要分组当时候：adapter.reloadSingleCell(cellVMList)
      - 需要分组当时候：this.adapter.reload(sections: sectionVMList)

### 垓项目会增加复杂度，但是层次会很清晰，对于复杂交互业务在后期维护更容易，同时也降低了项目耦合


eg:
> page:

```
class _HomePageState extends State<HomePage> {
  late HomePageVM vm = HomePageVM();

  @override
  void initState() {
    super.initState();
    vm.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SingleCellDemo'),
        ),
        body: AdapterListViewBuilder.builder(vm.adpater, reloadCall: () {
          if (mounted) setState(() {});
        }));
  }
}
```
<br/>

> pageVM:
```
import 'package:ec_adapter_demo/scr/cell.dart';
import 'package:ec_adapter/ec_adapter.dart';

class HomePageVM {
  late ListViewAdapter adpater = ListViewAdapter();
  onInit() {
    List<HomeCellVM> list = List.generate(10, (index) => index)
        .toList()
        .map((e) => HomeCellVM("Test index $e"))
        .toList();
    adpater.reloadSingleCell(list);
  }

  // if sections
  sections() {
    List<HomeCellVM> list1 = List.generate(10, (index) => index)
        .toList()
        .map((e) => HomeCellVM("Test index $e"))
        .toList();

    List<HomeCellVM> list2 = List.generate(10, (index) => 100 + index)
        .toList()
        .map((e) => HomeCellVM("Test index $e"))
        .toList();

    final List<ListViewBaseSectionItem> sectionList = [list1, list2]
        .map((e) => ListViewBaseSectionItem()..addItems(e))
        .toList();

    adpater.reload(sections: sectionList);
  }
}
```

<br/>

> cell & cellVM:
```import 'package:ec_adapter/ec_adapter.dart';
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


```
