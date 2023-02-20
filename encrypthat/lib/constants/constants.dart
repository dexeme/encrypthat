import 'package:flutter/material.dart';

import 'package:encrypthat/icons.dart';

const appBarColor = Color.fromRGBO(52, 52, 52, 1);
const bottomNavBarColor = Color.fromRGBO(32, 32, 32, 1);
const backgroundColor = Color.fromRGBO(255, 255, 255, 1);
const devicesPanelColor = Color.fromRGBO(246, 246, 246, 1);
const selectedItemColor = Color.fromRGBO(255, 255, 255, 1);
const unselectedItemColor = Color.fromRGBO(255, 255, 255, 0.5);
const buttonColor = Color.fromRGBO(0, 0, 0, 0.9);
const buttonColorPressed = Color.fromRGBO(0, 0, 0, 0.7);

const startScanButtonStyle = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

const keysInfoStyle = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black);

const keysNameStyle = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    
    color: Color.fromRGBO(0, 0, 0, 0.5));

const panelShadow = BoxShadow(
  color: Colors.black26,
  blurRadius: 1,
  spreadRadius: 1,
  offset: Offset(0, 1),
);

const bluetoothIcon = CustomIcons.bluetooth;

const regularFont = TextStyle(
    fontFamily: 'JetBrainsMono', fontSize: 16, fontWeight: FontWeight.normal);

const boldFont = TextStyle(
    fontFamily: 'JetBrainsMono', fontSize: 16, fontWeight: FontWeight.bold);
