import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/enums/enums.dart';
import '../../../../../domain/models/custom_wifi_point_model.dart';
import '../../../../utils/func.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());


  Future<void> init(List<CustomWifiPointModel> wifiList, List<CustomWifiPointModel> wifiListCache) async {
    emit(state.copyWith(status: BlocStatus.loading));
  final result =  Func.compareListWifi(wifiList, wifiListCache);
      emit(state.copyWith(
          status: BlocStatus.loaded,
          wifiList: result.newList,
          newWifiList: result.newItems,
          suspicious: result.newItems.length.toString(),
          secure: wifiListCache.isNotEmpty ?result.newList.length.toString() : '0',
        online: wifiList,
      ));
  }
}
