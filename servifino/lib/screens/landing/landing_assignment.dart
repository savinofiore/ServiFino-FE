import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servifino/utils/app_texts.dart';
import '../../models/WorksModel.dart';
import '../../providers/landing_assignment_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_routes.dart';

class LandingAssignment extends StatelessWidget {
  final List<WorkModel>? works;
  final UserProvider userProvider;

  LandingAssignment({
    Key? key,
    required this.works,
    required this.userProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landingProvider = Provider.of<LandingAssignmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppTexts.landing.assignTitle),
      ),
      body: landingProvider.isLoading == false
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: landingProvider.selectedWork,
                    hint:  Text(AppTexts.landing.selectWork),
                    onChanged: (value) {
                      landingProvider.setSelectedWork(value);
                    },
                    items: works?.map((work) {
                      return DropdownMenuItem<String>(
                        value: work.id,
                        child: Text(work.name),
                      );
                    }).toList(),
                  ),
                  if (landingProvider.selectedWork == 'owner') ...[
                    TextFormField(
                      decoration:
                           InputDecoration(labelText: AppTexts.landing.activityName),
                      onChanged: (value) {
                        landingProvider.updateOwnerDetail(
                            'activityName', value);
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: AppTexts.landing.activityDescription),
                      onChanged: (value) {
                        landingProvider.updateOwnerDetail(
                            'activityDescription', value);
                      },
                    ),
                    TextFormField(
                      decoration:
                           InputDecoration(labelText: AppTexts.landing.activityLocation),
                      onChanged: (value) {
                        landingProvider.updateOwnerDetail(
                            'activityLocation', value);
                      },
                    ),
                    TextFormField(
                      decoration:
                           InputDecoration(labelText: AppTexts.landing.activityWebSite),
                      onChanged: (value) {
                        landingProvider.updateOwnerDetail(
                            'activityWebsite', value);
                      },
                    ),
                    TextFormField(
                      decoration:
                           InputDecoration(labelText: AppTexts.landing.activityNumber),
                      onChanged: (value) {
                        landingProvider.updateOwnerDetail(
                            'activityNumber', value);
                      },
                    ),
                  ] else ...[
                    SwitchListTile(
                      title:  Text(AppTexts.landing.availabilty),
                      value: landingProvider.isAvailable,
                      onChanged: (value) {
                        landingProvider.setAvailability(value);
                      },
                    ),
                  ],
                  const Divider(),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await landingProvider.submitForm(userProvider.user);
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                              content:
                                  Text(AppTexts.controllers.successOperationMessage)),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppTexts.controllers.errorOperationMessage)),
                        );
                      }finally{
                        //Restart.restartApp();
                        Navigator.pushReplacementNamed(context, AppRoutes.authWrapper);
                        //AuthWrapper
                      }
                    } ,
                    child:  Text(AppTexts.controllers.confirm),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
