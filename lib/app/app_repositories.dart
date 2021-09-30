import 'package:flutter/material.dart';
import 'package:pmsc_auth/app/modules/auth/presenter/auth_repositories.dart';
import '../exports_pmsc.dart';

class AppRepositories extends StatelessWidget {
  const AppRepositories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: const AppProviders(),
    );
  }
}

List<RepositoryProvider> buildRepositories() => [
      RepositoryProvider(create: (BuildContext context) => ConfigService()),
      RepositoryProvider<IStorageService>(
          create: (BuildContext context) => StorageService()),
      RepositoryProvider<IApiService>(
          create: (BuildContext context) =>
              ApiService(context.read(), context.read())),
      ...AuthRepositories.buildRepositories()
    ];
