// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../../shared/components/components/components.dart';
import '../../../shared/components/constants/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shop_app/shop_layout.dart';
import 'cubit/shop_rgister_cubit.dart';
import 'cubit/states.dart';


class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginmodel.status)
            {
              print(state.loginmodel.message);
              print(state.loginmodel.data?.token);
              CacheHelper.setData(key: "_token", value: state.loginmodel.data?.token).then((value) {
                token=state.loginmodel.data?.token;
                showToast(state: ToastState.SUCCESS,text:state.loginmodel.message);
                navigateAndFinish(context, ShopLayout());

              });
            }
            else
            {
              showToast(state: ToastState.ERROR,text:state.loginmodel.message);
            }
          }
        },
        builder: (context, state) {
          var registerCubit = RegisterCubit.get(context);
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
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          "Register now to browse hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          onchange: (value) {},
                          onsubmitted: (value) {
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Name";
                            }
                          },
                          labeltext: "Name",
                          prefix: Icon(Icons.person_outline),
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
                          ispassword: registerCubit.ispassword,
                          onchange: (value) {},
                          onsubmitted: (value) {
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "please enter password";
                            }
                          },
                          labeltext: "password",
                          prefix: Icon(Icons.lock_outline_rounded),
                          suffix: registerCubit.suffix,
                          suffixSubmit: () {
                            registerCubit.changeSuffixIcon();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          onchange: (value) {},
                          onsubmitted: (value) {

                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Phone";
                            }
                          },
                          labeltext: "Phone",
                          prefix: Icon(Icons.phone),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                  );

                                }
                              },
                              text: "register",
                              isuppercase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
