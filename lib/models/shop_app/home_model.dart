

class HomeModel
{
 late bool? status;
 late HomeModelData data;
 HomeModel.formJson(Map<String,dynamic> json)
 {
   status=json["status"];
   data=HomeModelData.fromJson(json["data"]);

 }
}
class HomeModelData
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  HomeModelData.fromJson(Map<String,dynamic> json)
  {
    json["banners"].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });

    json["products"].forEach((element){
      products.add(ProductModel.fromJson(element));
    });

  }
}

class BannerModel
{
late int id ;
late String image;
BannerModel.fromJson(Map<String,dynamic> json)
{
  id=json["id"];
  image=json["image"];

}
}
class ProductModel
{
   late int id ;
   late dynamic oldPrice;
   late dynamic price ;
   late dynamic discount ;
   late String name ;
   late String image ;
    bool? isCart;
    bool? isFavorite;

   ProductModel.fromJson(Map<String,dynamic> product)
   {
     id=product["id"];
     oldPrice=product["old_price"];
     price=product["price"];
     discount=product["discount"];
     name=product["name"];
     image=product["image"];
     isCart=product["in_cart"];
     isFavorite=product["in_favorites"];
   }
}

