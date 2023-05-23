// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '';
import '../../../models/shop_app/shop_search_model.dart';
import '../../../shared/components/components/components.dart';
import '../../../shared/styles/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shop_app/shop_cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopSearchScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      defultTextFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          onchange: (value){},
                          onsubmitted: (value){
                            SearchCubit.get(context).getSearchData(text: value);
                          },
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                              {
                                return " must not be empty";
                              }
                            return null;
                          },
                          labeltext: "Search",
                          prefix: Icon(Icons.search)),
                      SizedBox(
                        height: 15,
                      ),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                      if(state is SearchGetDataSuccessState)
                       Expanded(
                        child: ListView.separated(
                            physics:BouncingScrollPhysics(),
                            itemBuilder: (context,index)=> SearchItemBuilder(SearchCubit.get(context).searchModel.data.data[index],context),
                            separatorBuilder: (context,index)=>mySparator(Colors.grey),
                            itemCount: SearchCubit.get(context).searchModel.data.data.length,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }


  Widget SearchItemBuilder(Product model,context)=>Padding(
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
