import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:servifino/pages/owner/history_owner.dart';
import 'package:servifino/pages/owner/home_owner.dart';
import 'package:servifino/pages/owner/profile_owner.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/utils/app_texts.dart';



class LandingOwner extends StatelessWidget {


  final List<Widget> _pages;
  late UserProvider userProvider;
  late OwnerProvider ownerProvider;

  LandingOwner({
    super.key,
    required this.userProvider,
    required this.ownerProvider
  }) : _pages = [
    HistoryOwner(),
    HomeOwner(user: userProvider.user),
    ProfileOwner(user: userProvider.user, owner: ownerProvider.owner,),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(1);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppTexts.title} - ${ownerProvider.owner?.activityName ?? 'Configura attività'} ',
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, child) {
          return _pages[selectedIndex];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: AppTexts.bottomBarTexts.firstIconText,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppTexts.bottomBarTexts.secondIconText,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: AppTexts.bottomBarTexts.thirdIconText,
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (index) {
              _selectedIndex.value = index;
            },
          );
        },
      ),
    );
  }
}

