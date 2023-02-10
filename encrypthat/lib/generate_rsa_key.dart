import 'package:flutter/material.dart';
import 'package:encrypthat/generate_new_rsa_key.dart';

class GenerateRSAKey extends StatefulWidget {
  const GenerateRSAKey({Key? key}) : super(key: key);

  @override
  State<GenerateRSAKey> createState() => _GenerateRSAKeyState();
}

class _GenerateRSAKeyState extends State<GenerateRSAKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Chave RSA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Public Key:'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GenerateNewRSAKey()),
                  );
                },
                child: const Text('Gerar Chave RSA'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
