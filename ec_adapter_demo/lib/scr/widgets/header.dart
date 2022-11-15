import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';

class ECCusterHeader extends StatelessWidget with ListViewHeaderFooterType {
  final String title;
  ECCusterHeader(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 30,
      child: Text(title),
    );
  }
}
