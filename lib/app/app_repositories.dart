import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pmsc_auth/app/modules/auth/presenter/auth_repositories.dart';
import '../exports_pmsc.dart';

class AppRepositories extends StatelessWidget {
  const AppRepositories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => Dio()),
        RepositoryProvider(create: (context) => ConfigService()),
        RepositoryProvider<IStorageService>(
            create: (context) => StorageService()),
        RepositoryProvider<IApiService>(
            create: (context) => ApiService(context.read(), context.read())),
        ...AuthRepositories.buildRepositories()
      ],
      child: const AppProviders(),
    );
  }
}
