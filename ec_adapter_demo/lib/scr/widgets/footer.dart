import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';

// ignore: must_be_immutable
class ECCusterFooter extends StatelessWidget with ListViewHeaderFooterType {
  final String title;
  ECCusterFooter(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 30,
      child: Text(title),
    );
  }
}
