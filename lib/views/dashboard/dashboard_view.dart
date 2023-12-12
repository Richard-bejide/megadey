
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:upgrader/upgrader.dart';
import '../../core/constants/colors.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  static const routeName = 'dashboardView';

  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => DashboardViewModel(),
        builder: (context, model, child) => WillPopScope(
            onWillPop: model.onWillPop,
            child: UpgradeAlert(
                //alert user whenever there is a new version on the store
                upgrader: Upgrader(
                    durationUntilAlertAgain: const Duration(minutes: 10),
                    showIgnore: false,
                    showLater: false,
                    canDismissDialog: false,
                    showReleaseNotes: true),
                child: Scaffold(
                  backgroundColor: Palette.backgroundColor,
                  body: IndexedStack(
                    index: model.selectedIndex,
                    children: model.pages,
                  ),
                  bottomNavigationBar: _showBottomNav(model, context),
                ))));
  }

  Widget _showBottomNav(DashboardViewModel model, BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: SvgPicture.asset('assets/icons/navigation/home.svg',
                  color: model.selectedIndex == 0 ? Palette.primaryColor : Colors.grey),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: SvgPicture.asset('assets/icons/navigation/favourites.svg',
                  color: model.selectedIndex == 1 ? Palette.primaryColor : Palette.customGrey),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SvgPicture.asset('assets/icons/navigation/sell.svg',
                  color: model.selectedIndex == 2 ? Palette.primaryColor : Palette.customGrey),
            ),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SvgPicture.asset('assets/icons/navigation/message.svg',
                  color: model.selectedIndex == 3 ? Palette.primaryColor : Palette.customGrey),
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SvgPicture.asset('assets/icons/navigation/profile.svg',
                  color: model.selectedIndex == 4 ? Palette.primaryColor : Palette.customGrey),
            ),
            label: 'You',
          ),
        ],
        currentIndex: model.selectedIndex,
        selectedItemColor: Palette.primaryColor,
        unselectedItemColor: Palette.customGrey,
        unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        selectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        onTap: (int value) {
          model.onTap(value, context);
        },
      ),
    );
  }
}
