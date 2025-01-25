import 'package:flutter/material.dart';

import '../../models/UserModel.dart';

class ProfileWorker extends StatelessWidget {
  late UserModel? user;


  ProfileWorker({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text('Profile worker ${user?.displayName}'),
    );
  }
}
