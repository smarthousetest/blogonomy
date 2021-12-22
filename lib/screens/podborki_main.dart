import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/widget/podborka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class PodborkiMain extends StatelessWidget {
  const PodborkiMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset('assets/icons/info_square.svg'),
              ),
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                color: Color(0xFFfff9e6),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Вы еще не создали ни одной подборки',
              style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontSize: 18.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ))),
                onPressed: () {
                  context.read<BottomNavigationControllerSelect>().select(1);
                  context.read<SlidingUpCubit2>().open();
                },
                child: const SizedBox(
                  height: 52,
                  child: Center(child: Text('Cоздать подборку')),
                )),
            const SizedBox(height: 26),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Podborka()));
                },
                child: const SizedBox(
                  child: Center(child: Text('Открыть подборку')),
                )),
          ],
        ),
      ),
    );
  }
}
