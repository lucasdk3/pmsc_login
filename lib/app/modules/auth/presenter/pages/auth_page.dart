// coverage:ignore-file
import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

class AuthPage extends BlocView<AuthCubit, AuthState> {
  AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Logo(),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                      color: backGroundWight,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            const Text('PMSC Chat',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Field(
                                controller: bloc.registrationController,
                                field: 'Matricula'),
                            Field(
                                controller: bloc.passwordController,
                                field: 'Senha'),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FingerButton(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                AuthButton()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
