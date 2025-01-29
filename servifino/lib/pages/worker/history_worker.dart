import 'package:flutter/material.dart';

import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class HistoryWorker extends StatelessWidget {
  late UserModel? user;
  late List<WorkModel>? works;
  HistoryWorker({
    super.key,
    required this.user,
    required this.works,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('History ${user?.displayName}'),
    );
  }
}
