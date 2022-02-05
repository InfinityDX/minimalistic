import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class TestChild extends StatefulWidget {
  const TestChild({required this.files, Key? key}) : super(key: key);

  final List<FileSystemEntity> files;

  @override
  State<TestChild> createState() => _TestChildState();
}

class _TestChildState extends State<TestChild> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          var name = basename(widget.files[index].path);
          return Text(name);
        });
  }
}
