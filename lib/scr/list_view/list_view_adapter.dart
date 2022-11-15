import 'package:ec_adapter/scr/core/core.dart';
import 'package:ec_adapter/scr/list_view/list_view_base.dart';
import 'package:flutter/material.dart';
import 'list_view_header_footer_type.dart';
import 'list_view_item_type.dart';
import 'list_view_section_type.dart';

class ListViewAdapter {
  /// 页面的控制器
  WeakReference? weakPageController;

  /// 用于页面刷新
  /// 当数据_sectionItems发生改变的时候则会执行该函数
  /// 如果使用getXContruoller则使用pageVM 直接 update即可
  Function()? reloadCall;

  /// 每个组之间的Separated
  final double sectionSeparated;

  /// 如果设置sectionSeparatedBuilder则sectionSeparated将废弃
  final Widget Function(int section)? sectionSeparatedBuilder;

  /// 当前的数据
  /// 类型：ListViewItemType _headerFooterItem _separatedItem
  final List<dynamic> _dataSource = [];

  /// 保存section数据
  final List<ListViewSectionItemType> _sectionItems = [];

  /// section设置圆角
  bool? _isSectionRand;

  /// section的圆角
  double? _sectionRadiu;

  ListViewAdapter(
      {Key? key,
      Object? pageController,
      this.sectionSeparated = 0.0,
      this.sectionSeparatedBuilder}) {
    if (pageController != null) {
      weakPageController = WeakReference(pageController);
    }
  }

  /// 刷新分组列表 可能包含sectionHeader、sectionFooter、separated
  /// 用于比较复杂的分组列表
  reload({List<ListViewSectionItemType>? sections}) {
    if (sections != null && sections.isNotEmpty) {
      _sectionItems.clear();
      _sectionItems.addAll(sections);
    }

    _doWithSectionToRow();
    if (reloadCall != null) reloadCall!();
  }

  /// 单列表的刷新
  /// 没有header、footer
  /// 每个cell可以存在自己的separated
  reloadSingleCell(List<ListViewItemType> datas) {
    ListViewBaseSectionItem section = ListViewBaseSectionItem();
    section.addItems(datas);
    _sectionItems.addAll([section]);
    reload(sections: [section]);
  }

  setRand(double radiu) {
    _isSectionRand = true;
    _sectionRadiu = radiu;
  }

  /// 将section转化成row
  _doWithSectionToRow() {
    _dataSource.clear();

    for (int i = 0; i < _sectionItems.length; i++) {
      ListViewSectionItemType sectionIten = _sectionItems[i];
      sectionIten.reloadList ??= () {
        reload();
      };

      // header
      if (sectionIten.headerBuilder != null) {
        _dataSource.add(_headerFooterItem(sectionIten));
      }

      // item
      for (int i = 0; i < sectionIten.items.length; i++) {
        ListViewItemType rowItem = sectionIten.items[i];
        _dataSource.add(rowItem);

        // item seprate
        if (rowItem.hasSeparated && i != (sectionIten.items.length - 1)) {
          if (rowItem.separatedBuilder != null) {
            _dataSource.add(
                _separatedItem(separatedBuilder: rowItem.separatedBuilder!));
          } else {
            _dataSource.add(_separatedItem(separated: rowItem.separated!));
          }
        }
      }

      // footer
      if (sectionIten.footerBuilder != null) {
        _dataSource.add(_headerFooterItem(sectionIten, isHeader: false));
      }

      // for section separated： 作为拓展还是加上
      if (sectionSeparated > 0 && i != _sectionItems.length - 1) {
        _dataSource.add(_separatedItem(separated: sectionSeparated));
      }
    }
  }

  /// 构建cell heder footer separated对应的Widget
  Widget buildListCell(BuildContext context, int index) {
    assert(index < _dataSource.length);

    if (index >= _dataSource.length) return Container();
    dynamic item = _dataSource[index];

    if (item is _separatedItem) {
      return item.builder();
    }

    if (item is _headerFooterItem) {
      ListViewSectionItemType sectionItem = item.sectionItem;
      ListViewHeaderFooterType headerFooter = item.builderHeaderFooter();

      // didSelect
      bool isFooterTapEnable = sectionItem.isFooterTapEnable && !item.isHeader;
      bool isHeaderTapEnable = sectionItem.isHeaderTapEnable && item.isHeader;
      if (isFooterTapEnable || isHeaderTapEnable) {
        return headerFooter.wrapGesture(() {
          headerFooter.didSelect(sectionItem);
          headerFooter.didSelectMoreItem(
              sectionItem, weakPageController?.target);
        });
      }

      return headerFooter;
    }

    if (item is ListViewItemType) {
      ListViewCellType cell = item.cellBuilder();
      cell.item = item;
      if (item.isTapEnable) {
        return cell.wrapGesture(() {
          cell.didSelect(item);
          if (item.sectionItem.target != null) {
            cell.didSelectMoreItem(
                item, item.sectionItem.target!, weakPageController?.target);
          }
        });
      }
      return cell;
    }
    assert(true, "section row计算出问题");
    return Container();
  }

  /// 计算cell的全部数量
  int get itemCount {
    return _dataSource.length;
  }
}

// /// 双向链表的数据数据节点
// class _ECAdapterNode {
//   /// 上一个节点
//   _ECAdapterNode? preNode;

//   /// 下一个节点
//   _ECAdapterNode? nextNode;

//   /// 当前的数据
//   /// 类型：ListViewItemType _headerFooterItem _separatedItem
//   final dynamic data;

//   _ECAdapterNode(this.data, {this.preNode, this.nextNode});
// }

/// section中头部/尾部的数据模型
// ignore: camel_case_types
class _headerFooterItem {
  final ListViewSectionItemType sectionItem;
  final bool isHeader;
  // ListViewHeaderFooterType Function() builder;
  _headerFooterItem(this.sectionItem, {this.isHeader = true});

  ListViewHeaderFooterType builderHeaderFooter() {
    if (isHeader) {
      assert(sectionItem.headerBuilder != null);
    } else {
      assert(sectionItem.footerBuilder != null);
    }

    ListViewHeaderFooterType headerFooter =
        isHeader ? sectionItem.headerBuilder!() : sectionItem.footerBuilder!();

    headerFooter.sectionItem = sectionItem;
    return headerFooter;
  }
}

/// separated的数据模型
// ignore: camel_case_types
class _separatedItem {
  static const int _maxcache = 100;

  /// 创建缓存区
  static const Map<double, _separatedItem> _cacheMap = {};

  /// 直接设置separated高度
  final double? separated;

  final Widget Function()? separatedBuilder;

  /// 如果用这个方法构建将不缓存，请采用create
  _separatedItem({this.separated, this.separatedBuilder});

  /// 采用静态方法构建,仅当separated情况会采用缓存方式
  static _separatedItem create(
      {double? separated, Widget Function()? separatedBuilder}) {
    if (separated != null) {
      _separatedItem? item = _cacheMap[separated];
      if (item != null) return item;
    }

    _separatedItem item = _separatedItem(
        separated: separated, separatedBuilder: separatedBuilder);
    if (separated != null && separatedBuilder == null) {
      _cacheMap[separated] = item;

      /// 如果缓存太大则清理部分(前面10个)
      if (_cacheMap.length > _maxcache) {
        List<double> keys = _cacheMap.keys.toList().sublist(0, 10);

        for (var element in keys) {
          _cacheMap.removeWhere((key, value) => key == element);
        }
      }
    }
    return item;
  }

  Widget builder() {
    if (separatedBuilder != null) {
      return separatedBuilder!();
    } else if (separated != null) {
      return SizedBox(height: separated!);
    } else {
      return Container();
    }
  }
}
