import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/enums/enums.dart';
import '../../../../../domain/models/custom_blue_point_model.dart';
import '../../../../utils/func.dart';

part 'search_blue_state.dart';

class SearchBlueCubit extends Cubit<SearchBlueState> {
  SearchBlueCubit() : super(const SearchBlueState());

  Future<void> init(List<CustomBluePointModel> blueList,
      List<CustomBluePointModel> blueListCache) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final result = Func.compareListBlue(blueList, blueListCache);
    emit(state.copyWith(
      status: BlocStatus.loaded,
      blueList: result.newList,
      newBlueList: result.newItems,
      online: blueList,
    ));
  }
}
