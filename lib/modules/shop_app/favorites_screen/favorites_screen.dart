// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/shop_app/favorite_model.dart';
import '../../../shared/components/components/components.dart';
import '../../../shared/styles/colors/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../../shop_app/shop_cubit/cubit.dart';
import '../../../shop_app/shop_cubit/states.dart';
class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state) {
          var cubit=ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopLoadingFavoriteDataState,
            builder: (context)=>ListView.separated(
                physics:BouncingScrollPhysics(),
                itemBuilder: (context,index)=> favoriteItemBuilder(ShopCubit.get(context).favoriteModel.data.data[index].product,context),
                separatorBuilder: (context,index)=>mySparator(Colors.grey),
                itemCount: ShopCubit.get(context).favoriteModel.data.data.length),
            fallback: (context)=>CircularProgressIndicator(),
          );
        }
    );
  }
  Widget favoriteItemBuilder(Product model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(

                image: NetworkImage(model.image),
                width:120,
                height: 120,
                fit: BoxFit.cover,
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
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Spacer(),
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
                    if (model.discount!= 0)
                      Text(
                        "${model.price}",
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
                        backgroundColor:ShopCubit.get(context).favorites[model.id]? defultcolor :Colors.grey,
                        child: Icon(Icons.favorite_outline,color: Colors.white,
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
    ),
  );
}
