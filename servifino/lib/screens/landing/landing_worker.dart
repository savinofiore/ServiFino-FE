import 'package:flutter/material.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/pages/worker/history_worker.dart';
import 'package:servifino/pages/worker/home_worker.dart';
import 'package:servifino/pages/worker/profile_worker.dart';
import '../../models/UserModel.dart';
import '../../utils/app_texts.dart';

class LandingWorker extends StatelessWidget {

  late UserModel? user;
  late List<WorkModel>? works;
  final List<Widget> _pages;

  LandingWorker({
    super.key,
    required this.user,
    required this.works
  }) : _pages = [
    HistoryWorker(user: user, works: works,),
    HomeWorker(user: user, works: works),
    ProfileWorker(user: user, works: works),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppTexts.title} ${works?.firstWhere((work) => work.id == user?.work, orElse: () => WorkModel(id: '', name: '', description: '')).name}',
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
