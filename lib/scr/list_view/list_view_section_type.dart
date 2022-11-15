import 'package:ec_adapter/scr/list_view/list_view_header_footer_type.dart';
import 'package:flutter/widgets.dart';
import 'list_view_item_type.dart';

/// section Type
mixin ListViewSectionItemType on Object {
  /// 直接设置separated高度，内部采用SizeBox实现
  double? separated;

  /// 如果这个方法不为null，则优先使用separatedBuilder，而废弃separated属性
  /// 不建议使用该方法
  Widget Function()? separatedBuilder;

  bool get _hasSeparated => separated != null || separatedBuilder != null;

  /// 是否能点击header、footer
  final bool isHeaderTapEnable = false;
  final bool isFooterTapEnable = false;

  /// headerBuilder和footerBuilder最终以cell的方式实现
  ListViewHeaderFooterType Function()? headerBuilder;
  ListViewHeaderFooterType Function()? footerBuilder;

  // int _allLength = 0;

  /// ListViewItemType配置列表
  final List<ListViewItemType> _items = [];

  List<ListViewItemType> get items => _items;

  /// 添加cellVM数组
  addItems(List<ListViewItemType> vms) {
    vms.forEach(_setupItem);
    _items.addAll(vms);
  }

  /// 删除某一个cellVM
  remove(ListViewItemType vm) {
    _items.remove(vm);
  }

  /// 添加一个cellVM
  add(ListViewItemType vm) {
    _setupItem(vm);
    _items.add(vm);
  }

  /// 让section可以更新整个的list
  /// 只要该section被刷新到ListView那么reloadList函数就一定存在
  Function()? reloadList;

  /// 没有item没有设置自己的 separatedBuilder、separated
  /// 而且section有设置，则会用section的给item设置
  _setupItem(ListViewItemType item) {
    item.sectionItem = WeakReference(this);

    if (!item.hasSeparated && _hasSeparated) {
      item.separated = separated;
      item.separatedBuilder = separatedBuilder;
    }
  }
}
