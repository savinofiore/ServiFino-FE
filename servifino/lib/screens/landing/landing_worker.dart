import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:servifino/interfaces/BaseLandingPage.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/pages/worker/history_worker.dart';
import 'package:servifino/pages/worker/home_worker.dart';
import 'package:servifino/pages/worker/profile_worker.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/utils/app_texts.dart';

class LandingWorker extends BaseLandingPage {
  LandingWorker({
    super.key,
    required List<WorkModel>? works,
    required UserProvider userProvider,
  }) : super(
    title: _getTitle(userProvider, works),
    pages: [
      HistoryWorker(user: userProvider.data, works: works),
      HomeWorker(user: userProvider.data, works: works),
      ProfileWorker(user: userProvider.data, works: works),
    ],
  );

  static String _getTitle(UserProvider userProvider, List<WorkModel>? works) {
    String workToRemove = dotenv.env['WORK_TO_REMOVE'] ?? '';
    works?.removeWhere((work) => work.id == workToRemove);
    return '${AppTexts.title} ${works?.firstWhere((work) => work.id == userProvider.data?.work, orElse: () => WorkModel(id: '', name: '', description: '')).name}';
  }
}
