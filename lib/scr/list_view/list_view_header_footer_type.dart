import 'package:ec_adapter/scr/list_view/list_view_section_type.dart';
import 'package:flutter/widgets.dart';

/// HeaderAndFooter Type
mixin ListViewHeaderFooterType<T extends ListViewSectionItemType> on Widget {
  /// cellVM
  late T sectionItem;

  /// 如果有点击事件则内部会用gs包一层，响应onTap事件
  /// 点击footer、header
  /// sectionItem sectionVM
  didSelect(T sectionItem) {}

  /// 点击footer、header
  /// sectionItem sectionVM
  /// pageItem pageController
  didSelectMoreItem<P extends Object>(T sectionItem, P? pageItem) {}
}
