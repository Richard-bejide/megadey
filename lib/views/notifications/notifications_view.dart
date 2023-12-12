import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import 'notifications_viewmodel.dart';

class NotificationsView extends StatelessWidget {
  static const routeName = 'notificationsView';

  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => NotificationsViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xFFF6F6F6),
                appBar: appBar(model, context),
                body: notificationsList(model))));
  }

  AppBar appBar(NotificationsViewModel model, BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      title: Text(
        'Notifications',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          // fontFamily: 'Circular Std',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.40,
        ),
      ),
    );
  }

  Widget notificationsList(NotificationsViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: model.notifications != null && model.notifications!.isNotEmpty
          ? ListView(children: [
              SizedBox(height: 15.0),
              model.notifications != null && model.notifications!.isNotEmpty
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          model.clearNotifications();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 14,
                              // fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: model.notifications?.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    Map? notification = model.notifications?[index];
                    return InkWell(
                      highlightColor: Palette.primaryColor.withOpacity(0.1),
                      onTap: () {
                        //
                      },
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.withOpacity(0.1),
                                backgroundImage: AssetImage(notification?["image"] ?? ''),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      notification?["title"] ?? '',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Palette.primaryColor,
                                        fontSize: 16,
                                        // fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 200,
                                    child: Text("${notification?["subtitle"]}",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Color(0xFF9F9F9F),
                                          fontSize: 14,
                                          // fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ])
          :  Center(
                child: Text(
                  'No new notifications',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    // fontFamily: 'Circular Std',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.24,
                  ),
                ),
            ),
    );
  }
}
