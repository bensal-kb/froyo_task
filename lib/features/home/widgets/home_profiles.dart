import 'package:flutter/material.dart';
import 'package:foyer/data/models/user_model.dart';
import 'package:foyer/features/home/home_vm.dart';
import 'package:foyer/widgets/header.dart';

import '../../../base/base_ui/base_stateless.dart';

class HomeProfiles extends BaseStateless<HomeVM> {
  const HomeProfiles({Key? key}) : super(key: key);

  @override
  Widget ui(BuildContext context, vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header('Users'),
          const SizedBox(height: 15),
          if(vm.userList.isEmpty)
            Center(
                child: Text(
                  'No Users found',
                  style: textStyle(
                      fontSize: 16, color: theme(context).warning()),
                )),
          for(UserModel i in vm.userList)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            latLongRow(
                                context, 'Latitude : ', i.lat.toString()),
                            const SizedBox(height: 5),
                            latLongRow(context, 'Longitude : ',
                                i.long.toString()),
                          ],
                        )

                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget latLongRow(context, String title, String? content) {
    return Row(
      children: [
        Text(
          title,
          style: textStyle(fontSize: 18, color: theme(context).titleLight1()),
        ),
        const SizedBox(width: 10),
        Text(
          content ?? '...',
          style: textStyle(fontSize: 16),
        ),
      ],
    );
  }
}
