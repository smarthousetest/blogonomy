import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:blogonomy/cubit/page_bloc.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/widget/profile.dart';
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
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                print("state = $state");
                if (state is LoginedState) {
                  return SlidingUp();
                }
                if (state is LogoutedState) {
                  return CollectionsPage();
                }
                if (state is EmptyState) {
                  return SlidingUp();
                }
                if (state is ErrorState) {
                  return SlidingUp();
                }
                return Text("erroe");
              },
            ),
          ),
          const SlidingUp2(),
          SlidingUp3()
        ]));
  }
}
