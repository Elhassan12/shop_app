import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/shop_cubit/states.dart';

import '../../../shared/network/end_points/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
class NewShopCubit extends Cubit<ShopStates>
{
  NewShopCubit():super(NewShopInitialState());
  static NewShopCubit get(context)=> BlocProvider.of(context);



}