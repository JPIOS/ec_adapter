import 'package:ec_adapter/scr/list_view/list_view_header_footer_type.dart';
import 'package:ec_adapter/scr/list_view/list_view_section_type.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class SectionHeaderView extends StatelessWidget with ListViewHeaderFooterType {
  SectionHeaderView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15),
      height: 40,
      child: Text(title),
    );
  }
}

// ignore: must_be_immutable
class SectionFooterView extends StatelessWidget with ListViewHeaderFooterType {
  SectionFooterView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5),
      height: 40,
      child: Text(title),
    );
  }
}

class MySectionItem with ListViewSectionItemType {
  final String sectionTitle;
  MySectionItem(this.sectionTitle) {
    // 如果需要组头部 则这里创建
    headerBuilder = () {
      return SectionHeaderView(title: "headerView $sectionTitle");
    };

    // 如果需要组尾部 则这里创建
    footerBuilder = () {
      return SectionFooterView(title: "footerView $sectionTitle");
    };
  }
}
