import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future logLogin() async {
    await _analytics.logEvent(name: 'Login_on_mobile_app');
  }

  Future logSignUp() async {
    await _analytics.logEvent(name: 'Sign_up_on_mobile_app');
  }

  Future logInitiatedSubscriptionPlan(String plan) async {
    await _analytics.logEvent(name: plan);
  }

  Future logLogout() async {
    await _analytics.logEvent(name: 'logout_on_mobile_app');
  }

  Future logDeleteAcct() async {
    await _analytics.logEvent(name: 'delete_account_on_mobile_app');
  }


  Future logImplementedFeatureTap(String featureName) async {
    await _analytics.logEvent(name: featureName);
  }

}
