import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../login_model.dart';

class LoginCubit extends Cubit<ShopLoginStates>
{
  LoginCubit():super(ShopLoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);
  late LoginModel loginModel ;

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login, data: {
      "email":email,
       "password":password,
    }).then((value){
      print(value.data);
      if(value.data !=null)
        {
          loginModel=LoginModel(value.data);

          print(loginModel.data?.id);
        }
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error: error.toString()));
      print(error.toString());
    });
  }
  bool ispassword = true;
  IconData suffix = Icons.visibility;
  void changeSuffixIcon()
  {
    ispassword=! ispassword;
    suffix = ispassword? Icons.visibility: Icons.visibility_off;
    emit(ShopLoginChangeVisibilityState());
  }

}
