import 'package:ec_adapter_demo/scr/widgets/footer.dart';
import '../../core/page_vm.dart';
import '../../widgets/custer_cell.dart';
import '../../widgets/header.dart';
import '../../widgets/separated.dart';
import 'package:get/get.dart';
import 'package:ec_adapter/ec_adapter.dart';

class ECHasSectionPageVM extends GetxController with ECPageVM {
  List<ListViewBaseSectionItem> datas = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    createSection1();
    createSection2();
    createSection3();
    createSection4();

    adapter.reload(sections: datas);
  }

  createSection1() {
    /// 第一组
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

  // have header
  createSection3() {
    ListViewBaseSectionItem section = ListViewBaseSectionItem();
    List<ECCusterCellVM> list = [0, 1, 3, 4, 5, 6].map((e) {
      ECCusterCellVM vm = ECCusterCellVM("第3组：标题$e", "点击cell可以删除：$e");
      vm.separated = 5.0 * e;
      if (e == 4) {
        // 自定义一个separated
        vm.separatedBuilder = () => ECCusterSeparated();
      }
      return vm;
    }).toList();

    section.headerBuilder = () => ECCusterHeader("第3组：我是自定义的头部,我只有头部");
    section.addItems(list);
    datas.add(section);
  }

  // have footer
  createSection4() {
    ListViewBaseSectionItem section = ListViewBaseSectionItem();
    List<ECCusterCellVM> list = [0, 1, 3, 4, 5, 6].map((e) {
      ECCusterCellVM vm = ECCusterCellVM("第4组：标题$e", "点击cell可以删除：$e");
      vm.separated = 5.0 * e;
      if (e == 4) {
        // 自定义一个separated
        vm.separatedBuilder = () => ECCusterSeparated();
      }
      return vm;
    }).toList();

    section.footerBuilder = () => ECCusterFooter("第4组：我是自定义的footer,我只有footer");
    section.addItems(list);
    datas.add(section);
  }
}
