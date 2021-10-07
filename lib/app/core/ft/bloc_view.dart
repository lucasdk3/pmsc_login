import 'package:flutter/material.dart';

import '../../../exports_pmsc.dart';

abstract class BlocView<T extends BlocBase<S>, S> extends StatelessWidget {
  BlocView({Key? key}) : super(key: key);

  final context = AppRouter.context;

  final String? tag = null;

  T get bloc => context!.read<T>();
  S get state => context!.watch<T>().state;
}
