import 'package:flutter/material.dart';

import '../../models/UserModel.dart';

class HomeWorker extends StatelessWidget {
  late UserModel? user;
  HomeWorker({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home worker ${user?.displayName}'),
    );
  }
}
