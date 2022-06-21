import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore_for_file: avoid_print
// ignore_for_file: prefer_const_constructors

infoDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  //Detecta si se está en Ios
  if (Platform.isIOS) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cerrar"))
            ],
          );
        });
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cerrar"))
          ],
        );
      });
}
