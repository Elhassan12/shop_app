// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../shared/components/components/components.dart';
import '../../../shared/styles/colors/colors.dart';
import '../../../shop_app/shop_cubit/cubit.dart';
import '../../../shop_app/shop_cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoriteSuccessState)
          {
            if (!state.changeFavoriteModel.status)
              {
                showToast(text: state.changeFavoriteModel.message, state:ToastState.ERROR);
              }
          }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder
          (
          condition: cubit.gettingHomeData && state is! ShopLoadingCategoriesDataState,
          builder: (context) => productBuilder(cubit.homeModel,cubit.categoryModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model ,CategoriesModel category,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data.banners
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image(
                            image: NetworkImage(e.image),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>categoryItem(category.data.data[index]),
                        separatorBuilder:(context,index)=> Container(width: 12,),
                        itemCount: category.data.data.length),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("New Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.685,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index],context),
                ),
                //
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                      color: Colors.red[500],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "DISCOUNT",
                          style: TextStyle(fontSize: 10),
                        ),
                      )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),

                  Row(
                    children: [
                      Text(
                        "${model.price}L.E",
                        style: TextStyle(
                            fontSize: 12, height: 1.3, color: defultcolor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice}",
                          style: TextStyle(
                              fontSize: 12,
                              height: 1.3,
                              color:  Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:ShopCubit.get(context).favorites[model.id]?defultcolor :Colors.grey,
                          child: Icon(Icons.add_shopping_cart,color: Colors.white,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget categoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
            model.image),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          Container(
              width: 100,
              color: Colors.black.withOpacity(.8),
              child: Text(
                model.name,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ))
        ],
      );
}
