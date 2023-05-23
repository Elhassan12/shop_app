
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/shop_cubit/states.dart';
import 'package:bloc/bloc.dart';

import '../../models/shop_app/categories_model.dart';
import '../../models/shop_app/change_favorite_model.dart';
import '../../models/shop_app/favorite_model.dart';
import '../../models/shop_app/home_model.dart';
import '../../modules/shop_app/categories_screen/categories_screen.dart';
import '../../modules/shop_app/favorites_screen/favorites_screen.dart';
import '../../modules/shop_app/home_screen/home_screen.dart';
import '../../modules/shop_app/login/login_model.dart';
import '../../modules/shop_app/settings_screen/settings_screen.dart';
import '../../shared/components/constants/constants.dart';
import '../../shared/network/end_points/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);
 int currentindex =0;
 List<Widget> navscreens=
 [
   HomeScreen(),
   CategoriesScreen(),
   FavoritesScreen(),
   SettingsScreen()

 ];
void changeNav(index)
{
  currentindex=index;
  emit(ShopChangeNavBarState());
}

late HomeModel homeModel;
late Map<int,dynamic> favorites={};
bool gettingHomeData= false;
void getHomeData()
{
  gettingHomeData= false;

  emit(ShopLoadingHomeDataState());

  DioHelper.getData(url: HOME ,token: token).then((value){

    homeModel=HomeModel.formJson(value.data);
    homeModel.data.products.forEach((element) { 
      favorites.addAll(
          {
            element.id:element.isFavorite
          }
      );
    });
print(favorites.toString());

    emit(ShopGetHomeDataSuccessState());
    gettingHomeData=true;
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorHomeDataState());
  });
}
late CategoriesModel categoryModel;

void getCategoriesData()
{
  emit(ShopLoadingCategoriesDataState());

  DioHelper.getData(url: Categories ).then((value){

    categoryModel=CategoriesModel.fromJson(value.data);

    emit(ShopGetCategoriesDataSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(ShopCategoriesErrorDataState());
  });
}
late  ChangeFavoriteModel changeFavoriteModel;

void changeFavorites(int productId)
{
  favorites[productId]=!favorites[productId];
  emit(ShopChangeFavoriteState());
  DioHelper.postData(
    url: FAVORITES,
    data:
    {
      "product_id":productId,
    },
    authorization: token,

  ).then((value) {
    changeFavoriteModel= ChangeFavoriteModel.fromJson(value.data);
  if(!changeFavoriteModel.status)
    {
      favorites[productId]=!favorites[productId];
    }else
      {
        getFavoriteData();
      }
    emit(ShopChangeFavoriteSuccessState(changeFavoriteModel));
  }).catchError((error){
    favorites[productId]=!favorites[productId];
    emit(ShopChangeFavoriteErrorState());
  });
}

  late FavoriteModel favoriteModel;
  void getFavoriteData()
  {
    emit(ShopLoadingFavoriteDataState());

    DioHelper.getData(url: FAVORITES,token: token).then((value){

      favoriteModel=FavoriteModel.fromJson(value.data);
      print(favoriteModel.toString());

      emit(ShopGetDataFavoriteSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetDataFavoriteErrorState());
    });
  }

late LoginModel userdata;

  void getProfileData()
  {
    emit(ShopLoadingProfileDataState());

    DioHelper.getData(url: PROFILE,token: token).then((value){

      userdata=LoginModel(value.data);
      print(userdata.toString());

      emit(ShopGetProfileDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetProfileDataErrorState());
    });
  }void updateUserData({
    required String name,
    required String phone,
    required String email,
  })
  {
    emit(ShopLoadingUpdateDataState());

    DioHelper.putData(url: UPDATE_PROFILE,token: token,
    query: {
      'email':email,
      'phone':phone,
      'name':name,
    }).then((value){

      userdata=LoginModel(value.data);
      print(userdata.toString());

      emit(ShopUpdateDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopUpdateErrorDataState());
    });
  }


}



