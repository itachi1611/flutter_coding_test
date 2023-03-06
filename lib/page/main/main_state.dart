part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({
    this.loadStatus,
    this.fits = const [],
  });

  final LoadStatus? loadStatus;

  final List<FitResponse>? fits;

  MainState copyWith({
    LoadStatus? loadStatus,
    List<FitResponse>? fits,
  }) {
    return MainState(
      loadStatus: loadStatus ?? this.loadStatus,
      fits: fits ?? this.fits,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        fits,
      ];
}
