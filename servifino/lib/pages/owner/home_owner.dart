import 'package:flutter/material.dart';
import 'package:servifino/models/OwnerModel.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/widgets/user_list_item.dart';

class HomeOwner extends StatelessWidget {
  late UserModel? user;
  late List<UserModel?> usersToBook;

  HomeOwner({
    super.key,
    required this.user,
    required this.usersToBook,
  });

  @override
  Widget build(BuildContext context) {
    return usersToBook.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: usersToBook.length,
            itemBuilder: (context, index) {
              final UserModel? user = usersToBook[index];
              return UserListItem(
                user: user,
                //owner: owner,
              );
            },
          );
  }
}
