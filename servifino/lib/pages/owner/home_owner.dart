import 'package:flutter/material.dart';

import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class HomeOwner extends StatelessWidget {
  late UserModel? user;
  HomeOwner({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home owner ${user?.displayName}'),
    );
  }
}
