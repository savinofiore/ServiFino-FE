import 'package:flutter/material.dart';
import 'package:servifino/pages/worker/history_worker.dart';
import 'package:servifino/pages/worker/home_worker.dart';
import 'package:servifino/pages/worker/profile_worker.dart';
import '../../models/UserModel.dart';
import '../../utils/app_texts.dart';

class LandingWorker extends StatelessWidget {
  late UserModel? user;
  //final UserProvider userProvider;
  final List<Widget> _pages;
  LandingWorker({
    super.key,
    required this.user,
  }) : _pages = [
    HistoryWorker(user: user),
    HomeWorker(user: user),
    ProfileWorker(user: user),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(1);


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${user?.displayName.toString()} ${user?.work.toString()}'),
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
