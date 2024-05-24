import 'package:ec_adapter/scr/list_view/list_view_header_footer_type.dart';
import 'package:flutter/widgets.dart';
import 'list_view_item_type.dart';

/// section Type
mixin ListViewSectionItemType<T extends ListViewItemType> on Object {
  /// 直接设置separated高度，内部采用SizeBox实现
  double? separated;

  /// item会对页面的控制器进行弱引用(如果有传则会)
  WeakReference? weakPageViewModel;

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
  final List<T> _items = [];

  List<T> get items => _items;

  /// 添加cellVM数组
  addItems(Iterable<T> vms) {
    vms.forEach(_setupItem);
    _items.addAll(vms);
  }

  /// 删除某一个cellVM
  remove(T vm) {
    _items.remove(vm);
  }

  /// 添加一个cellVM
  add(T vm) {
    _setupItem(vm);
    _items.add(vm);
  }

  clear() {
    _items.clear();
  }

  /// 让section可以更新整个的list
  /// 只要该section被刷新到ListView那么reloadList函数就一定存在
  Function()? reloadList;

  /// 没有item没有设置自己的 separatedBuilder、separated
  /// 而且section有设置，则会用section的给item设置
  _setupItem(T item) {
    item.sectionItem = WeakReference(this);

    if (!item.hasSeparated && _hasSeparated) {
      item.separated = separated;
      item.separatedBuilder = separatedBuilder;
    }
  }

  /// 设置section的圆角
  /// 一旦设置，则会对items构建的cell做圆角处理
  /// 背景会设置成白色
  /// 一旦设置了圆角，切不要设置
  /// separatedBuilder或者 separated
  double? sectionRadiu;
  bool get hasRadiu => sectionRadiu != null && sectionRadiu! > 0;
}
