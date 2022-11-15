import 'package:flutter/material.dart';

class ECCusterSeparated extends StatelessWidget {
  const ECCusterSeparated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      height: 30,
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text("我是自定义的separated,高度我自己决定"),
      ),
    );
  }
}
