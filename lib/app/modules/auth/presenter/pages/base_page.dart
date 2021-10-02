import 'package:flutter/material.dart';

import '../../../../../exports_pmsc.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Base'),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () => cubit.logout(), child: const Text('Sair')),
            )
          ],
        ),
      ),
    );
  }
}
