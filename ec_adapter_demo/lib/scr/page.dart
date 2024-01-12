import 'package:ec_adapter/ec_adapter.dart';
import 'package:flutter/material.dart';
import 'page_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageVM vm = HomePageVM();

  @override
  void initState() {
    super.initState();
    vm.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SingleCellDemo'),
        ),
        body: AdapterListViewBuilder.builder(vm.adpater, reloadCall: () {
          if (mounted) setState(() {});
        }));
  }
}
