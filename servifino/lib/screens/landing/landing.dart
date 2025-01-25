import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/providers/user_provider.dart';
import 'package:servifino/screens/landing/landing_owner.dart';
import 'package:servifino/screens/landing/landing_worker.dart';

import '../../models/UserModel.dart';
import 'landing_assignment.dart';

class LandingScreen extends StatelessWidget {
  late UserModel? user;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    user = userProvider.user;

    return user?.isOwner == true
        ? const LandingOwner()
        : user?.assignment == true
            ? LandingWorker(user: user,)
            : const LandingAssignment();
  }
}
