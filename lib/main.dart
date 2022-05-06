import 'package:blogonomy/auth/auth_page.dart';
import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/locator_services.dart';
import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/app_auth.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:blogonomy/cubit/network/bloger_find_model.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/filters_model.dart';
import 'package:blogonomy/cubit/network/podborka_bool.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/screens/about.dart';
import 'package:blogonomy/screens/confid.dart';
import 'package:blogonomy/screens/connection.dart';
import 'package:blogonomy/screens/help.dart';
//import 'package:blogonomy/screens/auth_screen.dart';
import 'package:blogonomy/screens/notifications.dart';
//import 'package:blogonomy/librur/bottom_bar.dart';
import 'package:blogonomy/widget/blogers.dart';
import 'package:blogonomy/widget/profile.dart';
import 'package:blogonomy/widget/collections.dart';
import 'package:blogonomy/widget/sliding_up/bloger_panel.dart';
import 'package:blogonomy/widget/sliding_up/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:blogonomy/cubit/locator_services.dart' as servic;
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'cubit/network/auth_cubit.dart';
import 'floating_bottom_navigation_bar-1.5.2/src/floating_navbar.dart';
import 'floating_bottom_navigation_bar-1.5.2/src/floating_navbar_item.dart';

FiltersModels filterModels = FiltersModels();
BlogerFindModel blogerFindModel = BlogerFindModel();
PodborkaBool podborkaBool = PodborkaBool();
AdminClass adminClass = AdminClass();
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await servic.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SlidingUpCubit>(
              create: (context) => sl<SlidingUpCubit>()),
          BlocProvider<SlidingUpCubit2>(
              create: (context) => sl<SlidingUpCubit2>()),
          BlocProvider<SlidingUpCubit3>(
              create: (context) => sl<SlidingUpCubit3>()),
          BlocProvider<SlidingUpCubit4>(
              create: (context) => sl<SlidingUpCubit4>()),
          BlocProvider<CardCubit>(create: (context) => sl<CardCubit>()),
          BlocProvider<CardCubit2>(create: (context) => sl<CardCubit2>()),
          BlocProvider<BlogersCubit>(create: (context) => sl<BlogersCubit>()),
          BlocProvider<BlogersCubit2>(create: (context) => sl<BlogersCubit2>()),
          BlocProvider<FilterCubit>(create: (context) => sl<FilterCubit>()),
          BlocProvider<OneBlogerCubit>(
              create: (context) => sl<OneBlogerCubit>()),
          BlocProvider<BottomNavigationControllerSelect>(
              create: (context) => sl<BottomNavigationControllerSelect>()),
          BlocProvider<AuthCubit>(
              create: (context) => sl<AuthCubit>()..check()),
          BlocProvider<AdminCubit>(create: (context) => sl<AdminCubit>()),
          BlocProvider<AuthApi>(create: (context) => sl<AuthApi>()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AuthPage();
            },
          ),
          routes: <String, WidgetBuilder>{
            '/a': (BuildContext context) => Notifications(),
            '/b': (BuildContext context) => Confid(),
            '/c': (BuildContext context) => const About(),
            '/d': (BuildContext context) => HelpPage(),
            '/e': (BuildContext context) => Connection(),
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     if (_selectedIndex == 2) {
  //       onTap();
  //     }
  //   });
  //   print(_selectedIndex);
  // }

  // onTap() {
  //   context.read<SlidingUpCubit>().open();
  // }

  final List<Widget> _widgetOptions = <Widget>[
    const CollectionsPage(),
    Blogers(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return BlocBuilder<BottomNavigationControllerSelect, int>(
      builder: (context, select) => Scaffold(
          body: _widgetOptions.elementAt(select),
          bottomNavigationBar: FloatingNavbar(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
              elevation: 0,
              margin: const EdgeInsets.only(left: 18, right: 18),
              selectedBackgroundColor: Colors.blue,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.white,
              itemBorderRadius: 23,
              // iconSize: 50,
              items: [
                FloatingNavbarItem(
                  customWidget: 'assets/icons/category_icon.svg',
                ),
                FloatingNavbarItem(
                  customWidget: 'assets/icons/star_icon.svg',
                ),
                FloatingNavbarItem(
                  customWidget: 'assets/icons/iconly_light_profile.svg',
                ),
              ],
              currentIndex: select,
              onTap: (index) {
                context.read<BottomNavigationControllerSelect>().select(index);
              })),
    );
  }
}
