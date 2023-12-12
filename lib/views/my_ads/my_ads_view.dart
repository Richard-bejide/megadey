import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/functions/format_price.dart';
import 'my_ads_viewmodel.dart';

class MyAdsView extends StatelessWidget {
  static const routeName = 'myAdsView';

  const MyAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAdsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => MyAdsViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Palette.backgroundColor,
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      const SizedBox(height: 10),
                      appBar(context),
                      const SizedBox(height: 5),
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              tab(
                                  title: 'Active',
                                  icon: 'assets/icons/active_ads.svg',
                                  onTap: () {
                                    model.currentTab = 0;
                                    model.notifyListeners();
                                  },
                                  bgColor: model.currentTab == 0
                                      ? Palette.primaryColor
                                      : Color(0xFFFAFAFA),
                                  contentColor:
                                      model.currentTab == 0 ? Colors.white : Palette.primaryColor),
                              const SizedBox(width: 5),
                              tab(
                                  title: 'Pending',
                                  icon: 'assets/icons/pending_ads.svg',
                                  onTap: () {
                                    model.currentTab = 1;
                                    model.notifyListeners();
                                  },
                                  bgColor: model.currentTab == 1
                                      ? Palette.primaryColor
                                      : Color(0xFFFAFAFA),
                                  contentColor:
                                      model.currentTab == 1 ? Colors.white : Palette.primaryColor),
                              const SizedBox(width: 5),
                              tab(
                                  title: 'Declined',
                                  icon: 'assets/icons/declined_ads.svg',
                                  onTap: () {
                                    model.currentTab = 2;
                                    model.notifyListeners();
                                  },
                                  bgColor: model.currentTab == 2
                                      ? Palette.primaryColor
                                      : Color(0xFFFAFAFA),
                                  contentColor:
                                      model.currentTab == 2 ? Colors.white : Palette.primaryColor),
                              const SizedBox(width: 5),
                              tab(
                                  title: 'Draft',
                                  icon: 'assets/icons/draft_ads.svg',
                                  onTap: () {
                                    model.currentTab = 3;
                                    model.notifyListeners();
                                  },
                                  bgColor: model.currentTab == 3
                                      ? Palette.primaryColor
                                      : Color(0xFFFAFAFA),
                                  contentColor:
                                      model.currentTab == 3 ? Colors.white : Palette.primaryColor),
                              const SizedBox(width: 5),
                              tab(
                                  title: 'Expired',
                                  icon: 'assets/icons/declined_ads.svg',
                                  onTap: () {
                                    model.currentTab = 4;
                                    model.notifyListeners();
                                  },
                                  bgColor: model.currentTab == 4
                                      ? Palette.primaryColor
                                      : Color(0xFFFAFAFA),
                                  contentColor:
                                  model.currentTab == 4 ? Colors.white : Palette.primaryColor),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: getPageView(model),
                        )),
                      ),
                    ])))));
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/arrow-left.svg', height: 20, width: 20),
            const SizedBox(width: 7),
            Text(
              'My Adverts',
              style: TextStyle(
                color: Color(0xFF222121),
                fontSize: 18,
                // fontFamily: 'Circular Std',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.27,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tab(
      {required String title,
      required String icon,
      required Function() onTap,
      required Color bgColor,
      required Color contentColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(color: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, height: 16, color: contentColor),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: contentColor,
                fontSize: 13,
                // fontFamily: 'Circular Std',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPageView(MyAdsViewModel model) {
    if (model.currentTab == 0) {
      return activeAds(model);
    } else if (model.currentTab == 1) {
      return pendingAds(model);
    } else if (model.currentTab == 2) {
      return declinedAds(model);
    } else if (model.currentTab == 3) {
      return draftedAds(model);
    } else if (model.currentTab == 4) {
      return expiredAds(model);
    } else {
      return Container();
    }
  }

  Widget activeAds(MyAdsViewModel model) {
    return model.activeAds != null && model.activeAds!.isNotEmpty
    ? ListView.builder(
        shrinkWrap: true,
        itemCount: model.activeAds?.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic>? activeAd = model.activeAds?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(activeAd?['image']),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeAd?['product_name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  // fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatPrice(activeAd?['price']),
                                style: TextStyle(
                                  color: Palette.primaryColor,
                                  fontSize: 14,
                                  fontFamily: '',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          //mark  as sold
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Mark as sold',
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 13,
                              // fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          );
        })
    : Center(
      child: Text(
        'There are no Ads yet.',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget pendingAds(MyAdsViewModel model) {
    return model.pendingAds != null && model.pendingAds!.isNotEmpty
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: model.activeAds?.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic>? pendingAd = model.pendingAds?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(pendingAd?['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pendingAd?['product_name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              // fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.28,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatPrice(pendingAd?['price']),
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 14,
                              fontFamily: '',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      //mark  as sold
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Mark as sold',
                        style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 13,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        })
        : Center(
      child: Text(
        'There are no Ads yet.',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget declinedAds(MyAdsViewModel model) {
    return model.declinedAds != null && model.declinedAds!.isNotEmpty
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: model.declinedAds?.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic>? declinedAd = model.declinedAds?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(declinedAd?['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            declinedAd?['product_name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              // fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.28,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatPrice(declinedAd?['price']),
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 14,
                              fontFamily: '',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      //mark  as sold
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Mark as sold',
                        style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 13,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        })
        : Center(
      child: Text(
        'There are no Ads yet.',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget draftedAds(MyAdsViewModel model) {
    return model.draftAds != null && model.draftAds!.isNotEmpty
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: model.declinedAds?.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic>? draftedAd = model.draftAds?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(draftedAd?['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            draftedAd?['product_name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              // fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.28,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatPrice(draftedAd?['price']),
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 14,
                              fontFamily: '',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      //mark  as sold
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Mark as sold',
                        style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 13,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        })
        : Center(
      child: Text(
        'There are no Ads yet.',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget expiredAds(MyAdsViewModel model) {
    return model.expiredAds != null && model.expiredAds!.isNotEmpty
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: model.expiredAds?.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic>? expired = model.expiredAds?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(expired?['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expired?['product_name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              // fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.28,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatPrice(expired?['price']),
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 14,
                              fontFamily: '',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        })
        : Center(
      child: Text(
        'There are no Ads yet.',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

}
