import 'package:servifino/interfaces/BaseLandingPage.dart';
import 'package:servifino/models/WorksModel.dart';
import 'package:servifino/pages/owner/history_owner.dart';
import 'package:servifino/pages/owner/home_owner.dart';
import 'package:servifino/pages/owner/profile_owner.dart';
import 'package:servifino/providers/modelsProviders/owner_provider.dart';
import 'package:servifino/providers/modelsProviders/user_provider.dart';
import 'package:servifino/utils/app_texts.dart';

class LandingOwner extends BaseLandingPage {
  LandingOwner({
    super.key,
    required UserProvider userProvider,
    required List<WorkModel>? works,
    required OwnerProvider ownerProvider,
  }) : super(
    title: '${AppTexts.title} - ${ownerProvider.data?.activityName ?? AppTexts.landing.activityNameDefault}',
    pages: [
      HistoryOwner(reservations: ownerProvider.reservationsList, works: works,),
      HomeOwner(user: userProvider.data, usersToBook: ownerProvider.usersToBook,),
      ProfileOwner(user: userProvider.data, owner: ownerProvider.data),
    ],
  );
}
