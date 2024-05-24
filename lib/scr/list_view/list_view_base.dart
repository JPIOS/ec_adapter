import 'package:ec_adapter/scr/list_view/list_view_item_type.dart';
import 'package:flutter/material.dart';
import 'list_view_header_footer_type.dart';
import 'list_view_section_type.dart';

class ListViewBaseSectionItem with ListViewSectionItemType {}

/// 可用于快速创建简单的header footer
// ignore: must_be_immutable
class ListViewBaseHeaderFooter extends StatelessWidget
    with ListViewHeaderFooterType {
  ListViewBaseHeaderFooter({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class ListViewBaseItem with ListViewItemType {
  @override
  ListViewCellType<ListViewBaseItem> cellBuilder() {
    return ListViewBaseCell();
  }
}

// ignore: must_be_immutable
class ListViewBaseCell extends StatefulWidget
    with ListViewCellType<ListViewBaseItem> {
  ListViewBaseCell({Key? key}) : super(key: key);

  @override
  State<ListViewBaseCell> createState() => _ListViewBaseCellState();
}

class _ListViewBaseCellState extends State<ListViewBaseCell> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
