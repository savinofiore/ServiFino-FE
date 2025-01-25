import 'package:flutter/material.dart';

import '../../models/UserModel.dart';

class HistoryWorker extends StatelessWidget {
  late UserModel? user;
  HistoryWorker({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('History ${user?.displayName}'),
    );
  }
}
