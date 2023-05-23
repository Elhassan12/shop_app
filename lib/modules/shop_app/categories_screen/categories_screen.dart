// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../shared/components/components/components.dart';
import '../../../shop_app/shop_cubit/cubit.dart';
import '../../../shop_app/shop_cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state) {
        var cubit=ShopCubit.get(context);
        return ListView.separated(
        physics:BouncingScrollPhysics(),
          itemBuilder: (contex,index)=> categoryItem(cubit.categoryModel.data.data[index]),
          separatorBuilder: (context,index)=>mySparator(Colors.grey),
          itemCount: cubit.categoryModel.data.data.length);
      }
    );
  }
}

Widget categoryItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                model.image),
            width: 120,
            height: 120,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
