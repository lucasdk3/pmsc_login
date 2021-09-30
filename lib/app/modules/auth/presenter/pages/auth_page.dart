import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'matricula'),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'senha'),
          ),
          const AuthButton()
        ],
      ),
    );
  }
}
