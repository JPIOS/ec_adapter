import 'package:ec_adapter_demo/scr/cell.dart';
import 'package:ec_adapter/ec_adapter.dart';

class HomePageVM {
  late ListViewAdapter adpater = ListViewAdapter();
  onInit() {
    // sections();
    singleCell();
  }

  // single cell
  void singleCell() {
    List<HomeCellVM> list = List.generate(10, (index) => index)
        .toList()
        .map((e) => HomeCellVM("single section", "index $e"))
        .toList();
    adpater.reloadSingleCell(list);
  }

  // if sections
  void sections() {
    List<HomeCellVM> list1 = List.generate(10, (index) => index)
        .toList()
        .map((e) => HomeCellVM("section one", "index $e"))
        .toList();

    List<HomeCellVM> list2 = List.generate(10, (index) => 100 + index)
        .toList()
        .map((e) => HomeCellVM("section two", "index $e"))
        .toList();

    final List<ListViewBaseSectionItem> sectionList = [list1, list2]
        .map((e) => ListViewBaseSectionItem()..addItems(e))
        .toList();

    adpater.reload(sections: sectionList);
  }
}
