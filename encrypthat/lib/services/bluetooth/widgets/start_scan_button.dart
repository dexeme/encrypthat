// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class StartScanButton extends StatefulWidget {
  final VoidCallback onPressed;

  const StartScanButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _StartScanButtonState createState() => _StartScanButtonState();
}

class _StartScanButtonState extends State<StartScanButton> {
  bool _isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isButtonEnabled
          ? () {
              widget.onPressed();
              setState(() {
                _isButtonEnabled = false;
              });
              Future.delayed(const Duration(seconds: 5), () {
                setState(() {
                  _isButtonEnabled = true;
                });
              });
            }
          : null,
      child: Container(
        width: 200,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isButtonEnabled ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Start Scan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
