import 'package:ec_adapter_demo/routers/router.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';
import 'home_cell.dart';

class HomePageVM extends GetxController {
  ListViewAdapter adapter = ListViewAdapter();
  @override
  onInit() {
    super.onInit();

    List<HomeCellVM> cellVMList = [
      HomeCellVM("只有cell", ECRouter.onlyCell),
      HomeCellVM("有cell和cell的separated", ECRouter.cellSeparamted),
      HomeCellVM("有section", ECRouter.hasSection),
      HomeCellVM(
          "有section和section的sectionSeparated", ECRouter.hasSectionSeparated),
    ];

    ListViewBaseSectionItem sectionVM = ListViewBaseSectionItem();
    sectionVM.addItems(cellVMList);

    // this.adapter.reload(sections: [
    //   sectionVM,
    // ]);

    /// 当不需要分组当时候可以直接刷新cellVM数组
    adapter.reloadSingleCell(cellVMList);
  }
}
