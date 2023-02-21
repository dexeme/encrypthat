// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:encrypthat/constants/constants.dart' as constants;

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
            }
          : null,
      child: Container(
        width: 300,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isButtonEnabled
              ? constants.buttonColor
              : constants.buttonColorPressed,
          borderRadius: BorderRadius.circular(30),
        ),
        child: _isButtonEnabled
            ? const Text('PROCURAR DISPOSITIVOS',
                style: constants.startScanButtonStyle)
            : const Text('PROCURANDO...',
                style: constants.startScanButtonStyle),
      ),
    );
  }
}
