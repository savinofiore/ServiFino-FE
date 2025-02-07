import 'package:servifino/interfaces/BaseProfile.dart';
import '../../models/UserModel.dart';
import '../../models/WorksModel.dart';

class ProfileWorker extends ProfileBase {
  final List<WorkModel>? works;

  ProfileWorker({
    super.key,
    required UserModel? user,
    required this.works,
  }) : super(
            title: '${user?.displayName} ${user?.work ?? ''}',
            subtitle: user?.email ?? '',
            user: user,
            works: works,
            additionalWidget: null);
}
