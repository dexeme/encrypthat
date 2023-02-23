import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/services/encryption/functions/key_pair_generator.dart';
import 'package:encrypthat/services/encryption/functions/signature_generator.dart';
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
  final bool _isButtonEnabled = true;
  bool? _isButtonAvailable;
  KeyPairGenerator keys = KeyPairGenerator.instance;
  SignatureGenerator signature = SignatureGenerator.instance;

  @override
  void initState() {
    super.initState();
    if (keys.publicKey == null || signature.signature == null) {
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
            }
          : null,
      child: Container(
          width: 300,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: signature.signature != null && keys.publicKey != null
                ? constants.buttonColor
                : constants.buttonColorDisabled,
            borderRadius: BorderRadius.circular(30),
          ),
          child: signature.signature != null && keys.publicKey != null
              ? const Text('VERIFICAR ASSINATURA',
                  style: constants.startScanButtonStyle)
              : const Text('VERIFICAR ASSINATURA',
                  style: constants.startScanButtonStyle)),
    );
  }
}
