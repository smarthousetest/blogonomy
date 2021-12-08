import 'package:blogonomy/cubit/page_bloc.dart';
import 'package:blogonomy/widget/sliding_up/bloger_panel.dart';
import 'package:blogonomy/widget/collections.dart';
import 'package:blogonomy/widget/sliding_up/sliding_up_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            switch (state) {
              case AuthState.auth:
                return const SlidingUp();
              case AuthState.nextCollections:
                return const CollectionsPage();
            }
          },
        ),
      ),
      const SlidingUp2(),
    ]));
  }
}
