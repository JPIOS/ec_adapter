import '../../widgets/custer_cell.dart';
import '../../widgets/footer.dart';
import '../../widgets/header.dart';
import '../../widgets/separated.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';

class ECHasSectionSeparatedPageVM extends GetxController {
  List<ListViewBaseSectionItem> datas = [];
  late ListViewAdapter adapter = ListViewAdapter(sectionSeparated: 20);
  @override
  void onInit() {
    super.onInit();
    createSection1();
    createSection2();

    adapter.reload(sections: datas);
  }

  // have header footer
  createSection1() {
    ListViewBaseSectionItem section = ListViewBaseSectionItem();
    List<ECCusterCellVM> list = [0, 1, 3, 4, 5, 6].map((e) {
      ECCusterCellVM vm = ECCusterCellVM("第1组：标题$e", "点击cell可以删除：$e");
      vm.separated = 5.0 * e;
      if (e == 4) {
        // 自定义一个separated
        vm.separatedBuilder = () => ECCusterSeparated();
      }
      return vm;
    }).toList();

    section.addItems(list);
    section.headerBuilder = () => ECCusterHeader("第1组：我是自定义的头部");
    section.footerBuilder = () => ECCusterFooter("第1组：我是自定义的footer");
    datas.add(section);
  }

  // have header footer
  createSection2() {
    ListViewBaseSectionItem section = ListViewBaseSectionItem();
    List<ECCusterCellVM> list = [0, 1, 3, 4, 5, 6].map((e) {
      ECCusterCellVM vm = ECCusterCellVM("第2组：标题$e", "点击cell可以删除：$e");
      vm.separated = 5.0 * e;
      if (e == 4) {
        // 自定义一个separated
        vm.separatedBuilder = () => ECCusterSeparated();
      }
      return vm;
    }).toList();

    section.addItems(list);
    section.headerBuilder = () => ECCusterHeader("第2组：我是自定义的头部");
    section.footerBuilder = () => ECCusterFooter("第2组：我是自定义的footer");
    datas.add(section);
  }
}
