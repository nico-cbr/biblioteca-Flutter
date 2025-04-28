// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'package:adotabr/wid/dmwid/conversas.dart';
import 'package:flutter/material.dart';

// ignore: c amel_case_types, camel_case_types
class dmPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Conversas"),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.amber.shade50),
            onPressed: () {},
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: ListView(
        children: [
          conversarDm(),
        ],
      )
    );
  }
  
}
