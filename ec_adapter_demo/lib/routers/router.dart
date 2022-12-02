import 'package:ec_adapter_demo/scr/home/home_page.dart';
import '../scr/home/home_page_vm.dart';
import 'package:get/get.dart';
import '../scr/pages/cell_separated/cell_separated_page.dart';
import '../scr/pages/has_section/has_section_page.dart';
import '../scr/pages/has_section/has_section_page_vm.dart';
import '../scr/pages/has_section_rand/has_section_rand_page.dart';
import '../scr/pages/has_section_separated/has_section_separated_page.dart';
import '../scr/pages/has_section_separated/has_section_separated_page_vm.dart';
import '../scr/pages/only_cell/only_cell_page.dart';
import '../scr/pages/page_view/ec_page_view_demo.dart';

class ECRouter {
  static String home = '/';
  static String onlyCell = '/ECOnlyCellPage';
  static String cellSeparamted = '/ECCellSeparamtedPage';
  static String hasSection = '/ECHasSectionPage';
  static String hasSectionSeparated = '/ECHasSectionSeparatedPage';
  static String hasSectionRand = '/ECHasSectionRandPage';
  static String pageView = '/pageView';

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: home,
        page: () => HomePage(),
        binding: BindingsBuilder.put(() => HomePageVM()),
      ),

      // exmpl
      GetPage(
        name: onlyCell,
        page: () => ECOnlyCellPage(),
        binding: BindingsBuilder.put(() => ECOnlyCellPageVM()),
      ),
      GetPage(
        name: cellSeparamted,
        page: () => ECCellSeparamtedPage(),
        binding: BindingsBuilder.put(() => ECCellSeparamtedPageVM()),
      ),

      GetPage(
        name: hasSection,
        page: () => ECHasSectionPage(),
        binding: BindingsBuilder.put(() => ECHasSectionPageVM()),
      ),

      GetPage(
        name: hasSectionSeparated,
        page: () => ECHasSectionSeparatedPage(),
        binding: BindingsBuilder.put(() => ECHasSectionSeparatedPageVM()),
      ),
      GetPage(
        name: hasSectionRand,
        page: () => ECHasSectionRandPage(),
        binding: BindingsBuilder.put(() => ECHasSectionRandPageVM()),
      ),

      GetPage(
        name: pageView,
        page: () => ECPageViewDemoPage(),
      ),
    ];
  }
}
