import 'package:flutter/material.dart';
import 'package:servifino/models/UserModel.dart';
import 'package:servifino/widgets/user_list_item.dart';

class HomeOwner extends StatelessWidget {
  late UserModel? user;
  late List<UserModel?> usersToBook;

  HomeOwner({super.key, required this.user, required this.usersToBook});

  @override
  Widget build(BuildContext context) {
    return usersToBook.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : /*ListView.builder(
            itemCount: usersToBook.length,
            itemBuilder: (context, index) {
              final UserModel? user = usersToBook[index];
              return ListTile(
                title: Text(user!.displayName),
                subtitle: Text(user.email),
                trailing: Text(user.isAvailable ? 'Available' : 'Not Available'),
              );
            },
          );*/
    ListView.builder(
      itemCount: usersToBook.length,
      itemBuilder: (context, index) {
        final UserModel? user = usersToBook[index];
        return UserListItem(
          user: user,
          onBookPressed: () {
            // Azione di prenotazione per l'utente specifico
            print("Prenotato: ${user!.displayName}");
          },
        );
      },
    );
  }
}
