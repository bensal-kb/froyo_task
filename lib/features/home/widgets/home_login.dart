import 'package:flutter/material.dart';
import 'package:foyer/features/home/home_vm.dart';
import 'package:foyer/features/home/widgets/home_new_user_prompt.dart';
import 'package:foyer/utils/validators.dart';
import 'package:foyer/widgets/button_widget.dart';
import 'package:foyer/widgets/field_widget.dart';
import 'package:foyer/widgets/header.dart';

import '../../../base/base_ui/base_stateful.dart';



class HomeLogin extends StatefulWidget {
  const HomeLogin({Key? key}) : super(key: key);

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends BaseStateful<HomeLogin, HomeVM> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget ui(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        color: theme(context).primaryLight(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Header(
                'Login Panel',
              ),
              const SizedBox(height: 15),
              label(context, 'Please Enter the Latitude'),
              FieldWidget(
                  controller: vm.latController,
                  hintText: 'eg: 38.8951',
                  validator: Validators.validateLat),
              const SizedBox(height: 15),
              label(context, 'Please Enter the Longitude'),
              FieldWidget(
                controller: vm.longController,
                hintText: 'eg: -77.0364 ',
                validator: Validators.validateLong,
              ),
              const SizedBox(height: 30),
              ButtonWidget(
                key: const Key('Login button'),
                title: 'Login',
                validate: () => _formKey.currentState!.validate(),
                onPressed: ()=>login(context),
                state: vm.loginState,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget label(context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
      child: Text(
        label,
        style: textStyle(fontSize: 16, color: theme(context).titleLight1()),
      ),
    );
  }

  login(context) async {
    bool? isExistingUser = await thisVM(context, false).login(context);
    if(isExistingUser == false) {
      bool? shouldCreateAccount = await showDialog<bool>(context: context, builder: (context) {
        return const HomeNewUserPrompt();
      });
      if(shouldCreateAccount == true) {
        thisVM(context, false).createUser(context);
      } else {
        thisVM(context, false).clear();
      }
    } else if(isExistingUser == true) {
      thisVM(context, false).switchToUser(context);
    }

  }
}

