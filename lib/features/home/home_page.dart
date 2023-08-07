import 'package:flutter/material.dart';
import 'package:foyer/features/home/widgets/home_login.dart';
import 'package:foyer/features/home/home_vm.dart';
import 'package:foyer/features/home/widgets/home_profile.dart';
import 'package:foyer/features/home/widgets/home_profiles.dart';

import '../../base/base_ui/base_stateless.dart';

class HomePage extends BaseStateless<HomeVM> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget ui(BuildContext context, vm) {
    return page(
      appBar: AppBar(
        title: Text('Froyo', style: textStyle(fontWeight: FontWeight.w700, fontSize: 20),),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 30),
          HomeLogin(),
          SizedBox(height: 30),
          HomeProfile(),
          SizedBox(height: 30),
          HomeProfiles(),
          SizedBox(height: 50,)
        ],
      )
    );
  }



  @override
  HomeVM? getVM(context) {
    return HomeVM();
  }


}
