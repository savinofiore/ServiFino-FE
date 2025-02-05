import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/owner_provider.dart';
import 'package:servifino/providers/user_provider.dart';
import 'package:servifino/screens/landing/landing_owner.dart';
import 'package:servifino/screens/landing/landing_worker.dart';
import '../../models/WorksModel.dart';
import '../../providers/works_provider.dart';

class LandingScreen extends StatelessWidget {
  //late UserModel? user;
  late List<WorkModel>? works;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final ownerProvider = Provider.of<OwnerProvider>(context);
    final worksProvider = Provider.of<WorksProvider>(context);

    works = worksProvider.worksList;

    return userProvider.user?.isOwner == true
            ? LandingOwner(
                userProvider: userProvider,
                ownerProvider: ownerProvider,
              )
            :
            LandingWorker(
                userProvider: userProvider,
                works: works,
              )

        ;
  }
}
