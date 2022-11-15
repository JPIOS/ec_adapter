import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';

mixin ECPageVM on GetxController {
  ListViewAdapter? _adapter;

  ListViewAdapter get adapter {
    if (_adapter != null) return _adapter!;
    _adapter = ListViewAdapter(pageController: this);
    return _adapter!;
  }
}
