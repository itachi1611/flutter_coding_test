import 'package:flutter_temp/models/responses/fit_response.dart';

import '../network/app_api.dart';

abstract class FitRepository {
  Future<List<FitResponse>?> getFitData();
}

class FitRepositoryImpl extends FitRepository {
  late AppApi _apiClient;

  FitRepositoryImpl(AppApi client) {
    _apiClient = client;
  }

  @override
  Future<List<FitResponse>?> getFitData() async {
    return await _apiClient.fetchFitData();
  }
}
