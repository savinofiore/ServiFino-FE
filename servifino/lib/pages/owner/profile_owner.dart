import 'package:flutter/material.dart';
import 'package:servifino/interfaces/BaseProfile.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/pages/owner/edit_profile_owner.dart';
import 'package:servifino/utils/app_texts.dart';
import '../../models/UserModel.dart';

class ProfileOwner extends ProfileBase {
  final OwnerModel? owner;

  ProfileOwner({
    super.key,
    required UserModel? user,
    required this.owner,
  }) : super(
            title: owner?.activityName ?? AppTexts.profileOwner.defaultActivityName,
            subtitle: user?.displayName ?? '',
            user: user,
            works: null,
            additionalWidget: OwnerProfileAdditionalWidget(user: user, owner: owner,));
}

class OwnerProfileAdditionalWidget extends StatelessWidget {
  final UserModel? user;
  final OwnerModel? owner;

   OwnerProfileAdditionalWidget({super.key, required this.user, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.edit, color: Colors.blueAccent),
          title: Text(AppTexts.profileOwner.editActivity),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditOwnerProfileScreen(user: user, owner: owner,)),
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}


