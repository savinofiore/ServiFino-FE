import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/user_provider.dart';
import 'package:servifino/screens/landing/landing_owner.dart';
import 'package:servifino/screens/landing/landing_worker.dart';

import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';
import '../../providers/works_provider.dart';
import 'landing_assignment.dart';

class LandingScreen extends StatelessWidget {
  late UserModel? user;
  late List<WorkModel>? works;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final worksProvider = Provider.of<WorksProvider>(context);
    user = userProvider.user;
    works = worksProvider.worksList;
    

    return user?.isOwner == true
        ? const LandingOwner()
        : user?.assignment == true
            ? LandingWorker(user: user, works: works,)
            : const LandingAssignment();
  }
}
