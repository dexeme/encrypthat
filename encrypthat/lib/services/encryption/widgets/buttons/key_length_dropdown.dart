import 'package:flutter/material.dart';

class KeyLengthDropdown extends StatefulWidget {
  final ValueChanged<int> onValueChanged;

  const KeyLengthDropdown({Key? key, required this.onValueChanged})
      : super(key: key);

  @override
  _KeyLengthDropdownState createState() => _KeyLengthDropdownState();
}

class _KeyLengthDropdownState extends State<KeyLengthDropdown> {
  int _value = 512;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _value,
      items: <int>[512, 1024, 2048]
          .map<DropdownMenuItem<int>>(
            (int value) => DropdownMenuItem<int>(
              value: value,
              child: Text('Key size: $value bits'),
            ),
          )
          .toList(),
      onChanged: (int? value) {
        if (value != null) {
          setState(() {
            _value = value;
          });
          widget.onValueChanged(value);
        }
      },
    );
  }
}
