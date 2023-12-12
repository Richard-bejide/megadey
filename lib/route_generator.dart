import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/ads_performance/ads_performance_view.dart';
import 'package:megadey_mobile/views/auth/forgot_password/forgot_password_view.dart';
import 'package:megadey_mobile/views/auth/sign_in_with_email/sign_in_with_email_view.dart';
import 'package:megadey_mobile/views/auth/signup/signup_view.dart';
import 'package:megadey_mobile/views/auth/signup/verify_otp/verify_otp_view.dart';
import 'package:megadey_mobile/views/business_details/business_details_view.dart';
import 'package:megadey_mobile/views/category_products/category_products_view.dart';
import 'package:megadey_mobile/views/change_email/change_email_view.dart';
import 'package:megadey_mobile/views/change_language/change_language_view.dart';
import 'package:megadey_mobile/views/change_password/change_password_view.dart';
import 'package:megadey_mobile/views/change_phone_number/change_phone_number_view.dart';
import 'package:megadey_mobile/views/chat/chat_view.dart';
import 'package:megadey_mobile/views/dashboard/dashboard_view.dart';
import 'package:megadey_mobile/views/delete_account/delete_account_view.dart';
import 'package:megadey_mobile/views/favourites/favourites_view.dart';
import 'package:megadey_mobile/views/home/home_view.dart';
import 'package:megadey_mobile/views/manage_notifications/manage_notifications_view.dart';
import 'package:megadey_mobile/views/megadey_plans/megadey_plans_view.dart';
import 'package:megadey_mobile/views/megadey_plans/payment/payment_view.dart';
import 'package:megadey_mobile/views/megadey_plans/selected_premium_plan/selected_premium_plan_view.dart';
import 'package:megadey_mobile/views/messages/messages_view.dart';
import 'package:megadey_mobile/views/my_ads/my_ads_view.dart';
import 'package:megadey_mobile/views/notifications/notifications_view.dart';
import 'package:megadey_mobile/views/onboarding/onboarding_view.dart';
import 'package:megadey_mobile/views/personal_details/personal_details_view.dart';
import 'package:megadey_mobile/views/product_description/product_description_view.dart';
import 'package:megadey_mobile/views/profile/profile_view.dart';
import 'package:megadey_mobile/views/search_product/search_product_view.dart';
import 'package:megadey_mobile/views/search_result/search_result_view.dart';
import 'package:megadey_mobile/views/sell/sell_view.dart';
import 'package:megadey_mobile/views/seller_page/seller_page_view.dart';
import 'package:megadey_mobile/views/settings/settings_view.dart';
import 'package:megadey_mobile/views/subcategories/subcategories_view.dart';
import 'package:megadey_mobile/views/view_all_deals/view_all_deals_view.dart';
import 'package:megadey_mobile/views/view_store/view_store_view.dart';
import 'package:megadey_mobile/views/wallet/wallet_view.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HomeView.routeName:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case ForgotPasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case SignupOtpView.routeName:
        return MaterialPageRoute(builder: (_) =>  SignupOtpView());
      case DashboardView.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (_) =>  OnboardingView());
      case SignInWithEmailView.routeName:
        return MaterialPageRoute(builder: (_) => const SignInWithEmailView());
      case SignupView.routeName:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case SearchProductView.routeName:
        return MaterialPageRoute(builder: (_) => const SearchProductView());
      case SearchResultView.routeName:
        return MaterialPageRoute(builder: (_) => const SearchResultView());
      case FavouritesView.routeName:
        return MaterialPageRoute(builder: (_) => const FavouritesView());
      case NotificationsView.routeName:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case MessagesView.routeName:
        return MaterialPageRoute(builder: (_) => const MessagesView());
      case ProductDescriptionView.routeName:
        return MaterialPageRoute(builder: (_) => const ProductDescriptionView());
      case SubCategoriesView.routeName:
        return MaterialPageRoute(builder: (_) => const SubCategoriesView());
      case CategoryProductsView.routeName:
        return MaterialPageRoute(builder: (_) => const CategoryProductsView());
      case ViewStoresView.routeName:
        return MaterialPageRoute(builder: (_) => const ViewStoresView());
      case ViewAllDealsView.routeName:
        return MaterialPageRoute(builder: (_) => const ViewAllDealsView());
      case ChatView.routeName:
        return MaterialPageRoute(builder: (_) => const ChatView());
      case SellerPageView.routeName:
        return MaterialPageRoute(builder: (_) => const SellerPageView());
      case ProfileView.routeName:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case SellView.routeName:
        return MaterialPageRoute(builder: (_) =>  SellView());
      case MegadeyPlansView.routeName:
        return MaterialPageRoute(builder: (_) =>  MegadeyPlansView());
      case SelectedPremiumPlanView.routeName:
        return MaterialPageRoute(builder: (_) =>  SelectedPremiumPlanView());
      case PaymentView.routeName:
        return MaterialPageRoute(builder: (_) =>  PaymentView());
      case AdsPerformanceView.routeName:
        return MaterialPageRoute(builder: (_) =>  AdsPerformanceView());
      case MyAdsView.routeName:
        return MaterialPageRoute(builder: (_) =>  MyAdsView());
      case SettingsView.routeName:
        return MaterialPageRoute(builder: (_) =>  SettingsView());
    case PersonalDetailsView.routeName:
    return MaterialPageRoute(builder: (_) =>  PersonalDetailsView());
      case ChangePhoneNumberView.routeName:
        return MaterialPageRoute(builder: (_) =>  ChangePhoneNumberView());
      case ChangeEmailView.routeName:
        return MaterialPageRoute(builder: (_) =>  ChangeEmailView());
      case ChangePasswordView.routeName:
        return MaterialPageRoute(builder: (_) =>  ChangePasswordView());
      case ChangeLanguageView.routeName:
        return MaterialPageRoute(builder: (_) =>  ChangeLanguageView());
      case DeleteAccountView.routeName:
        return MaterialPageRoute(builder: (_) =>  DeleteAccountView());
      case ManageNotificationsView.routeName:
        return MaterialPageRoute(builder: (_) =>  ManageNotificationsView());
      case WalletView.routeName:
        return MaterialPageRoute(builder: (_) =>  WalletView());
      case BusinessDetailsView.routeName:
        return MaterialPageRoute(builder: (_) =>  BusinessDetailsView());
      default:
        return MaterialPageRoute(builder: (_) => Container(color: Colors.white));
    }
  }
}
