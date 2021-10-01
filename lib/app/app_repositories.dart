import 'package:flutter/material.dart';
import '../exports_pmsc.dart';

class AppRepositories extends StatelessWidget {
  const AppRepositories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ConfigService()),
        RepositoryProvider<IStorageService>(
            create: (context) => StorageService()),
        RepositoryProvider<IApiService>(
            create: (context) => ApiService(context.read(), context.read())),
        RepositoryProvider<IAuthDatasouce>(
            create: (context) => AuthDatasourceImpl(context.read())),
        RepositoryProvider<IAuthRepository>(
            create: (context) => AuthRepositoryImpl(context.read())),
        RepositoryProvider<IAuthUseCase>(
            create: (context) => AuthUseCase(context.read(), context.read())),
        RepositoryProvider<IAuthWithFingerUseCase>(
            create: (context) =>
                AuthWithFingerUseCase(context.read(), context.read())),
        RepositoryProvider<ILogoutUseCase>(
            create: (context) => LogoutUseCase(context.read())),
      ],
      child: const AppProviders(),
    );
  }
}
