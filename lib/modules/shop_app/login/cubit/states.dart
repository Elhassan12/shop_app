
import '../login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState({required this.error});
}
class ShopLoginSuccessState extends ShopLoginStates {
  final LoginModel loginmodel;

  ShopLoginSuccessState(this.loginmodel);
}
class ShopLoginChangeVisibilityState extends ShopLoginStates {}
