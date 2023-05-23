
import '../../login/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates {}
class ShopRegisterLoadingState extends ShopRegisterStates {}
class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState({required this.error});
}
class ShopRegisterSuccessState extends ShopRegisterStates {
  final LoginModel loginmodel;

  ShopRegisterSuccessState(this.loginmodel);
}
class ShopRegisterChangeVisibilityState extends ShopRegisterStates {}
