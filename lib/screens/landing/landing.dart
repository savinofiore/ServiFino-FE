import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/screens/landing/landing_owner.dart';
import 'package:servifino/screens/landing/landing_worker.dart';
import '../../models/WorksModel.dart';
import '../../providers/modelsProviders/works_provider.dart';

class LandingScreen extends StatelessWidget {
  //late UserModel? user;
  late List<WorkModel>? works;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final ownerProvider = Provider.of<OwnerProvider>(context);
    final worksProvider = Provider.of<WorksProvider>(context);

    works = worksProvider.data;

    return userProvider.data?.isOwner == true
        ? LandingOwner(
            userProvider: userProvider,
            ownerProvider: ownerProvider,
            works: works,
          )
        : LandingWorker(
            userProvider: userProvider,
            works: works,
          );
  }
}
