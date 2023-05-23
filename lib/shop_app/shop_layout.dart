// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/shop_app/shop_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart';
import '../modules/shop_app/search_screen/search_screen.dart';
import '../shared/components/components/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getProfileData();
        return BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("Mega Store"),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, ShopSearchScreen());
                      },
                      icon: Icon(Icons.search)),
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Badge(
                      child: IconButton(
                          onPressed: () {
                            navigateTo(context, ShopSearchScreen());
                          },
                          icon: Icon(Icons.shopping_cart_outlined)),
                      badgeContent: Text("2"),
                    ),
                  ),
                ],
              ),
              body: cubit.navscreens[cubit.currentindex],
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps_outlined), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline), label: "Favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.changeNav(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
