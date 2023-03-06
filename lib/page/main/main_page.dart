import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/page/main/main_cubit.dart';

import '../../app/app_cubit.dart';
import '../../main.dart';
import '../../repositories/fit_repository.dart';
import '../../utils/app_connection.dart';
import 'items/fit_data_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  late final MainCubit _cubit;
  late final AppCubit _appCubit;
  late final FitRepository fitRepository;

  Map _source = {ConnectivityResult.none: false};
  final AppConnection _networkConnectivity = AppConnection.instance;

  @override
  void initState() {
    super.initState();
    final fitRepository = RepositoryProvider.of<FitRepository>(context);

    _appCubit = AppCubit();
    _cubit = MainCubit(fitRepository: fitRepository);
    _cubit.initData();

    _networkConnectivity.initialise();

    _networkConnectivity.myStream.listen((source) {
      _source = source;
      logger.i('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.mobileOnline
              : ConnectionStatus.mobileOffline);
          break;
        case ConnectivityResult.wifi:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.wifiOnline
              : ConnectionStatus.wifiOffline);
          break;
        case ConnectivityResult.none:
        default:
          _appCubit.setConnectionStatus(ConnectionStatus.offline);
          break;
      }
    });
  }

  void _onRefresh() {
    return _cubit.initData();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MainCubit, MainState>(
      bloc: _cubit,
      buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
      builder: (context, state) {
        switch(state.loadStatus) {
          case LoadStatus.loading:
            return const CircularProgressIndicator().center;
          case LoadStatus.fail:
            return _failWidget;
          default:
            return RefreshIndicator(
              onRefresh: () async  => _onRefresh(),
              child: FitDataWidget(
                fits: state.fits!,
              ),
            );
        }

      },
    );
  }

  /// Widget components
  Widget get _failWidget => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Error', style: TextStyle(fontSize: 14),).center,
      const SizedBox(height: 10,),
      IconButton(onPressed: _onRefresh, icon: const Icon(Icons.refresh, size: 30,))
    ],
  );

  @override
  bool get wantKeepAlive => true;
}
