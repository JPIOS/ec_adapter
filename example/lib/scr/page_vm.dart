import 'package:ec_adapter/ec_adapter.dart';
import 'package:example/scr/cell.dart';
import 'package:example/scr/section_vm.dart';

class HomePageVM {
  late ListViewAdapter adpater = ListViewAdapter();
  onInit() {
    // sections();
    singleCell();
  }

  // single cell
  void singleCell() {
    List<HomeCellVM> list = List.generate(
      10,
      (index) => index,
    ).map((e) => HomeCellVM("single section", "index $e")).toList();
    adpater.reloadSingleCell(list);
  }

  // if sections
  void sections() {
    List<HomeCellVM> list1 = List.generate(
      4,
      (index) => index,
    ).map((e) => HomeCellVM("section one", "index $e")).toList();

    List<HomeCellVM> list2 = List.generate(
      5,
      (index) => 100 + index,
    ).map((e) => HomeCellVM("section two", "index $e")).toList();

    final List<MySectionItem> sectionList = [list1, list2].indexed
        .map((e) => MySectionItem('Section: ${e.$1 + 1}')..addItems(e.$2))
        .toList();

    adpater.reload(sections: sectionList);
  }
}
