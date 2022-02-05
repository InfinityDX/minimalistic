import 'package:flutter/material.dart';

class TestStuff extends StatefulWidget {
  const TestStuff({Key? key}) : super(key: key);

  @override
  State<TestStuff> createState() => _TestStuffState();
}

class _TestStuffState extends State<TestStuff> {
  var status = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IgnorePointer(
          ignoring: true,
          child: SizedBox(
            width: 50,
            height: 50,
            child: TextButton(
              onPressed: () {},
              child: const Text('Click me'),
            ),
          ),
        ),
      ),
    );
  }
}
