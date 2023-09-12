part of 'search_blue_cubit.dart';

class SearchBlueState extends Equatable {
  const SearchBlueState({
    this.status = BlocStatus.initial,
    this.blueList = const [],
    this.newBlueList = const [],
    this.online = const [],
    this.error,
  });

  final BlocStatus status;
  final List<CustomBluePointModel> blueList;
  final List<CustomBluePointModel> newBlueList;
  final List<CustomBluePointModel> online;
  final String? error;

  @override
  List<Object?> get props => [
        online,
        status,
        blueList,
        newBlueList,
        error,
      ];

  SearchBlueState copyWith({
    BlocStatus? status,
    List<CustomBluePointModel>? blueList,
    List<CustomBluePointModel>? newBlueList,
    List<CustomBluePointModel>? online,
    String? error,
  }) {
    return SearchBlueState(
      status: status ?? this.status,
      blueList: blueList ?? this.blueList,
      newBlueList: newBlueList ?? this.newBlueList,
      online: online ?? this.online,
      error: error ?? this.error,
    );
  }
}
