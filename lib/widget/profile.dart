import 'dart:async';

import 'package:blogonomy/auth/auth_page.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit>().open();
    return Center(
      child: Image.network(
          'https://lh3.googleusercontent.com/proxy/TCLmxot4-EgQXN8pkEVyquRjyil8yLxiisUT50vrocd_4o9Z9vfkmsJbPY9N5X3eEThrO-kN9x_1fP8bmS12tp2WfSl9A2o1J-wonnR6oBYt480ry_FKPB5q_2eLaUE_-OO0YfsIBjfrWmvFGfywsBk4AKrt'),
    );
  }
}
