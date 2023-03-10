import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_view/splash_view.dart';

import '../home/home_page.dart';
import 'splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _splashCubit = SplashCubit();
    _splashCubit.onAnimateLogo();
  }

  @override
  void dispose() {
    _splashCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: _splashCubit,
      buildWhen: (pre, cur) => pre.logoStyle != cur.logoStyle,
      builder: (context, state) {
        return SplashView(
          logo: FlutterLogo(
            size: state.logoStyle != FlutterLogoStyle.markOnly ? 160 : 96,
            textColor: state.textColor,
            style: state.logoStyle,
          ),
          backgroundColor: Colors.white,
          //title: const Text('FLUTTER'),
          //subtitle: const Text('Welcome to community !'),
          bottomLoading: false,
          duration: const Duration(milliseconds: 2500),
          showStatusBar: false,
          done: Done(
            const HomePage(),
            animationDuration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        );
      },
    );
  }
}
