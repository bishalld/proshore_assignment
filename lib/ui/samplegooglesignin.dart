import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Aftergoogle extends StatefulWidget {
  final String email;
  final String name;

  const Aftergoogle({required this.email, required this.name, Key? key})
      : super(key: key);

  @override
  State<Aftergoogle> createState() => _AftergoogleState();
}

class _AftergoogleState extends State<Aftergoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ListTile(
          title: Text(widget.email),
          subtitle: Text(widget.name),
        )),
      ),
    );
  }
}
