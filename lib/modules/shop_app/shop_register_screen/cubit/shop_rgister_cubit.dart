import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/modules/shop_app/shop_register_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../login/login_model.dart';

class RegisterCubit extends Cubit<ShopRegisterStates>
{
  RegisterCubit():super(ShopRegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);
  late LoginModel registerModel ;

  void userRegister({
  required String email,
  required String password,
  required String phone,
  required String name,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      "email":email,
       "password":password,
       "phone":phone,
       "name":name,
    }).then((value){
      print(value.data);
      if(value.data !=null)
        {
          registerModel=LoginModel(value.data);
          print(value.data.toString());

          print(registerModel.data?.id);
        }
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      emit(ShopRegisterErrorState(error: error.toString()));
      print(error.toString());
    });
  }
  bool ispassword = true;
  IconData suffix = Icons.visibility;
  void changeSuffixIcon()
  {
    ispassword=! ispassword;
    suffix = ispassword? Icons.visibility: Icons.visibility_off;
    emit(ShopRegisterChangeVisibilityState());
  }

}
