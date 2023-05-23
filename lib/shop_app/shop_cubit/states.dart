
import '../../models/shop_app/change_favorite_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class NewShopInitialState extends ShopStates {}

class ShopChangeNavBarState extends ShopStates {}
class ShopGetHomeDataSuccessState extends ShopStates {}
class ShopLoadingHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}


class ShopGetCategoriesDataSuccessState extends ShopStates {}
class ShopLoadingCategoriesDataState extends ShopStates {}
class ShopCategoriesErrorDataState extends ShopStates {}
class ShopUpdateDataSuccessState extends ShopStates {}
class ShopLoadingUpdateDataState extends ShopStates {}
class ShopUpdateErrorDataState extends ShopStates {}
class ShopChangeFavoriteState extends ShopStates {}
class ShopChangeFavoriteSuccessState extends ShopStates {
  final ChangeFavoriteModel changeFavoriteModel;

  ShopChangeFavoriteSuccessState(this.changeFavoriteModel);
}
class ShopChangeFavoriteErrorState extends ShopStates {}

class ShopGetDataFavoriteErrorState extends ShopStates {}
class ShopGetDataFavoriteSuccessState extends ShopStates {}
class ShopLoadingFavoriteDataState extends ShopStates {}
class ShopGetProfileDataErrorState extends ShopStates {}
class ShopGetProfileDataSuccessState extends ShopStates {}
class ShopLoadingProfileDataState extends ShopStates {}
