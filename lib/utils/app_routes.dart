class AppRoutes {
  static const authWrapper = '/';
  static const String landing = '/landing';
  // Authentication
  static AuthRoutes auth = AuthRoutes();
  // Worker
  static WorkerRoutes worker = WorkerRoutes();
}

class AuthRoutes {
  final String login = '/login';
  final String register = '/register';
}

class WorkerRoutes {
  final String home = '/homeWorker';
  final String profile = '/profileWorker';
  final String history = '/historyWorker';
}
