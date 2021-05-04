import 'package:shopappwithapi/models/change_favorite_model.dart';

abstract class ShopStates {}

class ShopInitializeState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  final ChangeFavoriteModel changeFavoriteModel;

  ShopSuccessChangeFavoriteState(this.changeFavoriteModel);
}

class ShopChangeFavoriteState extends ShopStates {}

class ShopErrorChangeFavoriteState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}
