import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';
import 'home_page_vm.dart';

class HomePage extends GetView<HomePageVM> {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("home"),
        ),
        body: GetBuilder<HomePageVM>(
            builder: (e) => AdapterListViewBuilder.builder(
                    controller.adapter, reloadCall: () {
                  controller.update();
                })));
  }
}
