// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/services/encryption/key_pair_generator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class GenerateKeysButton extends StatefulWidget {
  final VoidCallback onPressed;

  const GenerateKeysButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  _GenerateKeysButtonState createState() => _GenerateKeysButtonState();
}

class _GenerateKeysButtonState extends State<GenerateKeysButton> {
  bool _isButtonEnabled = true;
  bool? _isButtonAvailable;
  KeyPairGenerator keys = KeyPairGenerator.instance;

  @override
  void initState() {
    super.initState();
    if (keys.privateKey == null || keys.publicKey == null) {
      _isButtonAvailable = true;
    } else {
      _isButtonAvailable = false;
    }
  }

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
            ? const Text('GERAR CHAVES', style: constants.startScanButtonStyle)
            : const Text('GERANDO...', style: constants.startScanButtonStyle),
      ),
    );
  }
}
