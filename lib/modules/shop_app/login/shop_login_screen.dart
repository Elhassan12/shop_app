// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/components/components/components.dart';
import '../../../shared/components/constants/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shop_app/shop_cubit/cubit.dart';
import '../../../shop_app/shop_layout.dart';
import '../shop_register_screen/shop_register_screen.dart';
import 'cubit/shop_login_cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if(state is ShopLoginSuccessState)
              {
                if(state.loginmodel.status)
                  {
                    print(state.loginmodel.message);
                    print(state.loginmodel.data?.token);
                    CacheHelper.setData(key: "_token", value: state.loginmodel.data?.token).
                    then((value) {
                      token=state.loginmodel.data?.token;
                      print(token);
                      ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getProfileData();
                      if(ShopCubit.get(context).gettingHomeData) {
                        showToast(state: ToastState.SUCCESS,
                            text: state.loginmodel.message);
                        navigateAndFinish(context, ShopLayout());
                      }
                    });
                  }
                else
                {
                  showToast(state: ToastState.ERROR,text:state.loginmodel.message);
                }
              }
          },
          builder: (context, state) {
            LoginCubit loginCubit = LoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 10,),
                          Text(
                            "Login",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            "login now to browse hot offers",
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            onchange: (value) {},
                            onsubmitted: (value) {},
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "please enter email";
                              }
                            },
                            labeltext: "Email Address",
                            prefix: Icon(Icons.email_outlined),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            ispassword: loginCubit.ispassword,
                            onchange: (value) {},
                            onsubmitted: (value) {

                              if (formkey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                                // navigateAndFinish(context, ShopHomeScreen());
                              }

                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "please enter password";
                              }
                            },
                            labeltext: "password",
                            prefix: Icon(Icons.lock_outline_rounded),
                            suffix: loginCubit.suffix,
                            suffixSubmit:(){
                              loginCubit.changeSuffixIcon();
                            },


                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) =>
                                defaultButton(
                                    function: () {
                                      if (formkey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text
                                        );
                                        // navigateAndFinish(context, ShopHomeScreen());
                                      }
                                    }, text: "login",
                                    isuppercase: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have an account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              deflutTextButton(
                                  onPressed: () {
                                    navigateAndFinish(
                                        context, ShopRegisterScreen());
                                  },
                                  text: "Register"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
