import 'package:ec_adapter/scr/core/core.dart';
import 'package:ec_adapter/scr/list_view/list_view_base.dart';
import 'package:flutter/material.dart';
import 'list_view_header_footer_type.dart';
import 'list_view_item_type.dart';
import 'list_view_section_type.dart';

class ListViewAdapter<PVM extends Object> {
  /// 页面的控制器VM
  WeakReference<PVM>? weakPageViewModel;

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

  /// 列表头部 最多一个 listFooter
  Widget? listHeader;

  /// 列表底部，最多一个 listFooter
  Widget? listFooter;

  ListViewAdapter(
      {Key? key,
      PVM? pageVM,
      this.sectionSeparated = 0.0,
      this.sectionSeparatedBuilder}) {
    if (pageVM != null) {
      weakPageViewModel = WeakReference(pageVM);
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

  /// 将section转化成row
  _doWithSectionToRow() {
    _dataSource.clear();

    for (int i = 0; i < _sectionItems.length; i++) {
      ListViewSectionItemType sectionItem = _sectionItems[i];

      sectionItem.reloadList ??= () {
        reload();
      };

      if (weakPageViewModel?.target != null) {
        sectionItem.weakPageViewModel =
            WeakReference(weakPageViewModel!.target!);
      }

      // header
      if (sectionItem.headerBuilder != null) {
        _dataSource.add(_headerFooterItem(sectionItem));
      }

      // item
      for (int i = 0; i < sectionItem.items.length; i++) {
        ListViewItemType rowItem = sectionItem.items[i];

        // 如果不展示则不添加在数据源中
        if (!rowItem.showItem) continue;
        _dataSource.add(rowItem);

        // item seprate
        if (rowItem.hasSeparated && i != (sectionItem.items.length - 1)) {
          if (rowItem.separatedBuilder != null) {
            _dataSource.add(
                _separatedItem(separatedBuilder: rowItem.separatedBuilder!));
          } else {
            _dataSource.add(_separatedItem(separated: rowItem.separated!));
          }
        }
      }

      // 圆角处理
      if (sectionItem.hasRadius) {
        sectionItem.items
            .where((element) => element.showItem)
            .firstOrNull
            ?.topRadiu = sectionItem.sectionRadius;

        sectionItem.items.reversed
            .where((element) => element.showItem)
            .firstOrNull
            ?.bottomRadiu = sectionItem.sectionRadius;
      }

      // footer
      if (sectionItem.footerBuilder != null) {
        _dataSource.add(_headerFooterItem(sectionItem, isHeader: false));
      }

      // for section separated： 作为拓展还是加上
      if (sectionSeparated > 0 &&
          i != _sectionItems.length - 1 &&
          sectionSeparatedBuilder != null) {
        _dataSource.add(_separatedItem(separated: sectionSeparated));
      }

      if (sectionSeparatedBuilder != null && i != _sectionItems.length - 1) {
        _dataSource.add(_separatedItem(separatedBuilder: () {
          return sectionSeparatedBuilder!.call(i);
        }));
      }
    }

    // list footer
    if (listHeader != null) {
      _dataSource.add(_listHeaderFooterItem(header: listHeader));
    }
    // list footer
    if (listFooter != null) {
      _dataSource.add(_listHeaderFooterItem(footer: listFooter));
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
              sectionItem, weakPageViewModel?.target);
        });
      }

      return headerFooter;
    }

    if (item is ListViewItemType) {
      ListViewCellType cell = item.cellBuilder();
      Widget widgetCell = cell;

      cell.item = item;

      if (weakPageViewModel?.target != null) {
        item.weakPageViewModel = WeakReference(weakPageViewModel!.target!);
      }

      if (item.isTapEnable) {
        widgetCell = cell.wrapGesture(() {
          cell.didSelect(item);
          if (item.sectionItem?.target != null) {
            cell.didSelectSection(item, item.sectionItem!.target!);
          }

          if (weakPageViewModel?.target != null) {
            cell.didSelectPageVM(item, weakPageViewModel!.target!);
          }

          if (item.sectionItem?.target != null &&
              weakPageViewModel?.target != null) {
            cell.didSelectMoreItem(
                item, item.sectionItem!.target!, weakPageViewModel?.target);
          }
        });
      }

      // 头部圆角
      if (item.topRadiu != null && item.topRadiu! > 0) {
        widgetCell = ClipRRect(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(item.topRadiu!)),
            child: widgetCell);
      }

      /// 底部圆角
      if (item.bottomRadiu != null && item.bottomRadiu! > 0) {
        widgetCell = ClipRRect(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(item.bottomRadiu!)),
          child: widgetCell,
        );
      }
      return widgetCell;
    }

    if (item is _listHeaderFooterItem) {
      if (item.footer != null) return item.footer!;
      if (item.header != null) return item.header!;
    }
    assert(true, "section row计算出问题");
    return Container();
  }

  /// 计算cell的全部数量
  int get itemCount {
    return _dataSource.length;
  }
}

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

// ignore: camel_case_types
class _listHeaderFooterItem {
  final Widget? footer;
  final Widget? header;

  _listHeaderFooterItem({this.header, this.footer});
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
