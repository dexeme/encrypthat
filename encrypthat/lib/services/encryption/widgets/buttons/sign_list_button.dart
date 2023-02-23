import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/services/encryption/functions/key_pair_generator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class SignListButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SignListButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _SignListButtonState createState() => _SignListButtonState();
}

class _SignListButtonState extends State<SignListButton> {
  bool _isButtonEnabled = true;
  KeyPairGenerator keys = KeyPairGenerator.instance;
  bool? _isButtonAvailable;

  @override
  void initState() {
    super.initState();
    _isButtonAvailableCheck();
  }

  _isButtonAvailableCheck() {
    if (keys.publicKey == null || keys.privateKey == null) {
      setState(() {
        _isButtonAvailable = false;
      });
    } else {
      setState(() {
        _isButtonAvailable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isButtonAvailable!
          ? () {
              widget.onPressed();
            }
          : null,
      child: Container(
        width: 300,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isButtonAvailable!
              ? constants.buttonColor
              : constants.buttonColorDisabled,
          borderRadius: BorderRadius.circular(30),
        ),
        child: _isButtonAvailable!
            ? const Text('ASSINAR LISTA', style: constants.startScanButtonStyle)
            : const Text('ASSINAR LISTA',
                style: constants.startScanButtonStyle),
      ),
    );
  }
}
