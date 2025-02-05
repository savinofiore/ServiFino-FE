import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/pages/worker/history_worker.dart';
import 'package:servifino/pages/worker/home_worker.dart';
import 'package:servifino/pages/worker/profile_worker.dart';
import 'package:servifino/providers/user_provider.dart';
import '../../utils/app_texts.dart';

class LandingWorker extends StatelessWidget {

  //late UserModel? user;
  late List<WorkModel>? works;
  final List<Widget> _pages;
  late UserProvider userProvider;

  LandingWorker({
    super.key,
    //required this.user,
    required this.works,
    required this.userProvider
  }) : _pages = [
    HistoryWorker(user: userProvider.user, works: works,),
    HomeWorker(user: userProvider.user, works: works),
    ProfileWorker(user: userProvider.user, works: works),
  ];

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(1);


  @override
  Widget build(BuildContext context) {
    String workToRemove = dotenv.env['WORK_TO_REMOVE'] ?? '';
    works?.removeWhere((work) => work.id == workToRemove);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppTexts.title} ${works?.firstWhere((work) => work.id == userProvider.user?.work, orElse: () => WorkModel(id: '', name: '', description: '')).name}',
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
