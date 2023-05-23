// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';


import '../../../shared/components/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors/colors.dart';
import '../../../shop_app/shop_cubit/cubit.dart';
import '../../../shop_app/shop_cubit/states.dart';
import '../edit_profile/edit_profile.dart';
import '../login/shop_login_screen.dart';
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
     builder: (context,state){
        var cubit =ShopCubit.get(context);
       return  Padding(
         padding: const EdgeInsets.all(15.0),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.end,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text(
                   "Profile",
                   style: TextStyle(
                     fontSize: 25,
                     color: defultcolor,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 Spacer(),
                 IconButton(
                   onPressed: () {
                     navigateTo(context, EditProfile());
                   },
                   icon: Icon(
                     Icons.edit,
                     size: 25,

                   ),
                   padding: EdgeInsets.zero,
                 ),
               ],
             ),
             SizedBox(
               height: 10,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(40),
                   child: Image(
                     image: NetworkImage(
                         "${cubit.userdata.data?.image}"),
                     fit: BoxFit.cover,
                     width: 100,
                     height: 100,
                   ),
                 ),
                 SizedBox(width: 10),
                 Expanded(
                     child: Text(
                       "${cubit.userdata.data?.name}",
                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                     )),
               ],
             ),
             SizedBox(height: 40),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Row(
                 children: [
                   Icon(Icons.phone),
                   SizedBox(
                     width: 10,
                   ),
                   Text(
                     "${cubit.userdata.data?.phone}",
                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                   ),
                 ],
               ),
             ),
             SizedBox(
               height: 10,
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Row(
                 children: [
                   Icon(Icons.email_outlined),
                   SizedBox(
                     width: 10,
                   ),
                   Text(
                     "${cubit.userdata.data?.email}",
                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                   ),
                 ],
               ),
             ),
             Spacer(),
             defaultButton(function: (){signOut(context,ShopLoginScreen(),"_token");}, text: "logout", isuppercase: true),
             SizedBox(
               height: 20,
             ),

           ],
         ),
       );
     } ,
    );
  }
}
