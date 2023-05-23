
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search_screen/cubit/states.dart';

import '../../../../models/shop_app/shop_search_model.dart';
import '../../../../shared/components/constants/constants.dart';
import '../../../../shared/network/end_points/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';
class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);
  late SearchModel searchModel;

  void getSearchData({
    required String text,
  })
  {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH,authorization: token,
        data: {
      text:text
        }).then((value){

      searchModel=SearchModel.fromJson(value.data);
      print(searchModel.toString());

      emit(SearchGetDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchGetDataErrorState());
    });
  }


}