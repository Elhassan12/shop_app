import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components/components.dart';
import '../../../shop_app/shop_cubit/cubit.dart';
import '../../../shop_app/shop_cubit/states.dart';

//validation.

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = ShopCubit.get(context).userdata;
        nameController.text = ShopCubit.get(context).userdata.data!.name!;
        emailController.text = userData.data!.email!;
        phoneController.text = userData.data!.phone ?? "";
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateDataState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    defultTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      onchange: (value) {},
                      onsubmitted: (value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "name must not be empty";
                        }
                        return null;
                      },
                      labeltext: "Name",
                      prefix: Icon(Icons.person),
                    ),
                    SizedBox(height: 15),
                    defultTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      onchange: (value) {},
                      onsubmitted: (value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Email must not be empty";
                        }
                        return null;
                      },
                      labeltext: "Email",
                      prefix: Icon(Icons.email_outlined),
                    ),
                    SizedBox(height: 15),
                    defultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      onchange: (value) {},
                      onsubmitted: (value) {

                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone must not be empty";
                        }
                        return null;
                      },
                      labeltext: "Phone",
                      prefix: Icon(Icons.phone),
                    ),
                    SizedBox(height: 15),
                    defaultButton(
                        function: () {
                          if(formkey.currentState!.validate())
                          {
                            cubit.updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text);
                          }
                        },
                        text: "Update",
                        isuppercase: true),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
