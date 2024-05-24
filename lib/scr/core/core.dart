import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import '../list_view/list_view_adapter.dart';

class AdapterListViewBuilder {
  /// 通用ListView
  /// 通过 adpater的_sectionItems来控制ListView
  static ListView builder(
    ListViewAdapter adpater, {
    required Function() reloadCall,
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Widget? listFooter,
    Widget? listHeader,
  }) {
    /// 让adpater持有reloadCall
    adpater.reloadCall ??= reloadCall;
    adpater.listFooter = listFooter;
    adpater.listHeader = listHeader;

    return ListView.builder(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      findChildIndexCallback: findChildIndexCallback,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      itemBuilder: (context, index) {
        return adpater.buildListCell(context, index);
      },
      itemCount: adpater.itemCount,
    );
  }

  /// 通用 PageView
  /// 通过 adpater的_sectionItems来控制ListView
  static PageView pageBuilder(
    ListViewAdapter adpater, {
    required Function() reloadCall,
    Key? key,
    Axis scrollDirection = Axis.horizontal,
    bool reverse = false,
    PageController? controller,
    ScrollPhysics? physics,
    bool pageSnapping = true,
    void Function(int)? onPageChanged,
    int? Function(Key)? findChildIndexCallback,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool allowImplicitScrolling = false,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    ScrollBehavior? scrollBehavior,
    bool padEnds = true,
  }) {
    /// 让adpater持有reloadCall
    adpater.reloadCall ??= reloadCall;

    return PageView.builder(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      physics: physics,
      pageSnapping: pageSnapping,
      onPageChanged: onPageChanged,
      findChildIndexCallback: findChildIndexCallback,
      dragStartBehavior: dragStartBehavior,
      allowImplicitScrolling: allowImplicitScrolling,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      scrollBehavior: scrollBehavior,
      itemBuilder: (context, index) {
        return adpater.buildListCell(context, index);
      },
      itemCount: adpater.itemCount,
    );
  }

  /// 创建section具备圆角的功能，section可以包含header和footer
  /// ListViewAdapter初始化的时候需要配置sectionSeparated属性,并大于0
  /// padding默认两边边距是16
  /// 需要注意的是
  /// section的最后一个视图和第一视图高度需要比
  /// sectionSeparated高，否则有可能会出现ui上的一些问题
  // static ListView adapterRandBuilder(ListViewAdapter adpater,
  //     {required double radiu,
  //     EdgeInsets? padding = const EdgeInsets.only(left: 16, right: 16),
  //     required Function() reloadCall}) {
  //   assert(adpater.sectionSeparated > 0);

  //   adpater.setRand(radiu);
  //   return adapterBuilder(adpater, reloadCall: reloadCall, padding: padding);
  // }
}

extension WrapGestureExtention on Widget {
  Widget wrapGesture(Function() tap) {
    return GestureDetector(
      onTap: tap,
      child: this,
    );
  }
}
