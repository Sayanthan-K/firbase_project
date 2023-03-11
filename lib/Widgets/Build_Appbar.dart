import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/Colors.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    title: Center(child: Text("Recipe Application")),

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Icon(
    //       Icons.menu,
    //       color: tdBlack,
    //       size: 30,
    //     ),
    //     Container(
    //       height: 40,
    //       width: 40,
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(20),
    //         child: Image.asset('assets/images/pro.jpg'),
    //       ),
    //     ),
    //   ],
    // ),
  );
}
