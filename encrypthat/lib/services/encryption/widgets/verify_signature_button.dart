// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/services/encryption/key_pair_generator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class VerifySignatureButton extends StatefulWidget {
  final VoidCallback onPressed;

  const VerifySignatureButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  _VerifySignatureButtonState createState() => _VerifySignatureButtonState();
}

class _VerifySignatureButtonState extends State<VerifySignatureButton> {
  bool _isButtonEnabled = true;
  bool? _isButtonAvailable;
  KeyPairGenerator keys = KeyPairGenerator.instance;

  @override
  void initState() {
    super.initState();
    if (keys.publicKey == null) {
      _isButtonAvailable = false;
    } else {
      _isButtonAvailable = true;
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
              Future.delayed(const Duration(seconds: 2), () {
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
            ? const Text('VERIFICAR ASSINATURA',
                style: constants.startScanButtonStyle)
            : const Text('VERIFICANDO...',
                style: constants.startScanButtonStyle),
      ),
    );
  }
}
