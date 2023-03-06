import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/models/responses/fit_response.dart';
import 'package:flutter_temp/repositories/fit_repository.dart';

import '../../main.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final FitRepository fitRepository;

  MainCubit({required this.fitRepository}) : super(const MainState());

  void initData() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));

    try {
      final result = await fitRepository.getFitData();
      if(result != null && result.isNotEmpty) {
        emit(state.copyWith(loadStatus: LoadStatus.success, fits: result));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.fail));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.fail));
      logger.e(e);
    }
  }
}
