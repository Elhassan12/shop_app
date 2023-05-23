// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../../modules/shop_app/login/shop_login_screen.dart';
import '../../cubit/cubit.dart';
import '../../network/local/cache_helper.dart';
import '../../styles/icon_broken.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
  required bool isuppercase,

}) =>
    Container(
      height: 35,

      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: background,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: background,
      ),
// decoration:  ,
      child: MaterialButton(
        onPressed: function,
        child: Text(isuppercase ? text.toUpperCase() : text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget deflutTextButton({
  required VoidCallback onPressed,
  required String text,})
{
  return TextButton(onPressed: onPressed , child: Text("${text.toUpperCase()}"));
}

Widget defultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function(String) onchange,
  required Function(String) onsubmitted,
  required final FormFieldValidator<String>? validator,
  bool ispassword = false,
  required String labeltext,
  required Icon prefix,
  IconData? suffix,
  VoidCallback? suffixSubmit,
  VoidCallback? ontap,

}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: ispassword,
        onChanged: onchange,
        onFieldSubmitted: onsubmitted,
        onTap: ontap,
        validator: validator,
        decoration: InputDecoration(
          labelText: labeltext,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: prefix,
          suffixIcon: IconButton(icon: Icon(suffix), onPressed: suffixSubmit),
        )
    );

PreferredSizeWidget defaultAppBar({required BuildContext context,String title="",List<Widget>? actions })
{
  return AppBar(
    title:Text("$title"),
    actions: actions,
    leading: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(IconBroken.Arrow___Left_2)),
    titleSpacing: 0.5,
  );
}

Widget taskItem(Map map, context) =>
    Dismissible(
      key: Key("${map["id"]}"),
      onDismissed: (dirction) {
        AppCubit.getInstance(context).deleteData(id: map["id"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(

              radius: 40,
              child: Text("${map["time"]}"),
            ),
            SizedBox(
              width: 15,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${map["title"]}", maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 3,),
                  Text("${map["date"]}",
                    style: TextStyle(color: Colors.grey[500]),),

                ],
              ),
            ),
            SizedBox(
              width: 15,),
            IconButton(onPressed: () {
              AppCubit.getInstance(context).updateData(
                  id: map['id'], status: "Done");
            }, icon: Icon(Icons.check_box_outlined), color: Colors.blue,),
            SizedBox(
              width: 5,),
            IconButton(onPressed: () {
              AppCubit.getInstance(context).updateData(
                  id: map['id'], status: "Archived");
            }, icon: Icon(Icons.archive_outlined), color: Colors.grey,),
          ],
        ),

      ),
    );

Widget conditional({required List<Map> tasks}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) =>
          ListView.separated(
              itemBuilder: (context, index) => taskItem(tasks[index], context),
              separatorBuilder: (context, index) => mySparator(Colors.blue),
              itemCount: tasks.length),
      fallback: (context) =>
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_sharp, size: 50, color: Colors.grey[400]),
                Text("No Tasks Yet,please Add Some Tasks",
                  style: TextStyle(fontSize: 20, color: Colors.grey[400]),),
              ],
            ),
          ),
    );

Widget articleItem(list, context) =>
    InkWell(
      onTap: () {
         // navigateTo(context, WebView(initialUrl: list['url'],));

      },
      child: Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              width: 120,

              height: 120,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),

                  image: DecorationImage(

                    image: NetworkImage(list["urlToImage"] == null
                        ? "https://upload.wikimedia.org/wikipedia/commons/4/4f/Logo-khabar.png"
                        : "${list["urlToImage"]}"),

                    fit: BoxFit.cover,

                  )),

            ),

            SizedBox(

              width: 5,

            ),

            Expanded(

              child: Container(

                height: 120,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                        child: Text(

                          "${list["title"]}",

                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,

                          maxLines: 3,

                          overflow: TextOverflow.ellipsis,

                        )),

                    Text(

                      "${list["publishedAt"]}",

                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,

                    )

                  ],

                ),

              ),

            )

          ],

        ),

      ),
    );

Widget mySparator(Color color) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: color,

      ),
    );

Widget newsPage(list, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) =>
          ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => articleItem(list[index], context),
            separatorBuilder: (context, index) => mySparator(Colors.deepOrange),
            itemCount: 10,
          ),
      fallback: (context) =>
      isSearch ? Container() : Center(
          child: CircularProgressIndicator(color: Colors.deepOrange,)),
    );

void navigateTo(context, widget) async =>
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget,));


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String text,
  required ToastState state,
})
{
   Fluttertoast.showToast(
    msg: text,
    backgroundColor:chooseColor(state),
    textColor: Colors.white,
    fontSize: 16,
    timeInSecForIosWeb: 5,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}
enum ToastState{WARNING,SUCCESS,ERROR}

Color chooseColor(ToastState state)
{
  Color color;
  switch(state){
      case ToastState.SUCCESS:
          color=Colors.green;
           break;
      case ToastState.WARNING:
           color=Colors.amber;
           break;
      case ToastState.ERROR:
          color=Colors.red;
          break;
  }
  return color;
}

void signOut(context ,widget,key)
{
  CacheHelper.removeData(key: "key").then((value) {

    if(value) {

      navigateAndFinish(context, widget);
    }
  });
}
