import 'package:servifino/interfaces/BaseLandingPage.dart';
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
    required OwnerProvider ownerProvider,
  }) : super(
    title: '${AppTexts.title} - ${ownerProvider.data?.activityName ?? 'Configura attività'}',
    pages: [
      HistoryOwner(),
      HomeOwner(user: userProvider.data, usersToBook: ownerProvider.usersToBook,),
      ProfileOwner(user: userProvider.data, owner: ownerProvider.data),
    ],
  );
}
