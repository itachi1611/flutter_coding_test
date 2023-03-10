import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void onAnimateLogo() {
    Future.delayed(const Duration(milliseconds: 1250), () async {
      emit(state.copyWith(logoStyle: FlutterLogoStyle.markOnly));
    });
  }
}
