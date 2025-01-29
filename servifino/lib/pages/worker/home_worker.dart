import 'package:flutter/material.dart';

import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class HomeWorker extends StatelessWidget {
  late UserModel? user;
  late List<WorkModel>? works;
  HomeWorker({
    super.key,
    required this.user,
    required this.works,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home worker ${user?.displayName}'),
    );
  }
}
