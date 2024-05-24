import 'package:flutter/widgets.dart';
import 'list_view_section_type.dart';

/// item Type
// abstract class
mixin ListViewItemType {
  /// cell的构建方法,混入必须实现
  ListViewCellType cellBuilder();

  /// 直接设置separated高度，内部采用SizeBox实现
  /// 即使sectionType设置了该属性，此优先级更高
  double? separated;

  /// 如果这个方法不为null，则优先使用separatedBuilder，而废弃separated属性
  /// 即使sectionType设置了该属性，此优先级更高
  /// 不建议使用该方法
  Widget Function()? separatedBuilder;

  /// 是否可以点击
  /// 默认cell是可以点击的
  bool isTapEnable = true;

  /// item会对section进行弱引用
  WeakReference<ListViewSectionItemType>? sectionItem;

  /// item会对页面的控制器进行弱引用(如果有传则会)
  WeakReference? weakPageViewModel;

  /// 是否有separated
  bool get hasSeparated =>
      (separated != null && separated! > 0.0) || separatedBuilder != null;

  /// 是否展示这个item
  bool showItem = true;

  /// 用于制作圆角
  double? topRadiu;
  double? bottomRadiu;
}

/// cell Type
/// 如果需要点击事件，则cell需要遵守这个协议，
/// 内部会把对应pageVM、sectionVM、cellVM，直接传过来
mixin ListViewCellType<T extends ListViewItemType> on Widget {
  /// cellVM
  late T item;

  /// 点击选中了cell
  didSelect(T item) {}

  /// 传入secttionItem
  didSelectSection<S extends ListViewSectionItemType>(T t, S sectionItem) {}

  /// 传入pageItem
  didSelectPageVM<P extends Object>(T t, P pageItem) {}

  /// 更多参数输入
  didSelectMoreItem<S extends ListViewSectionItemType, P extends Object>(
      T item, S sectionItem, P? pageItem) {}
}
