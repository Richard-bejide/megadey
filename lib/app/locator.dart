import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:megadey_mobile/core/services/analytics_service.dart';
import 'package:megadey_mobile/core/services/profile_service.dart';
import 'package:megadey_mobile/core/services/video_player_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';
import '../core/services/signup_service.dart';
import '../core/services/utility_storage_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({bool test = false}) async {
  Directory appDocDir = test ? Directory.current : await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  if (!test) {
    locator.registerLazySingleton<HiveInterface>(() => Hive);
  }
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );
  locator.registerLazySingleton<SnackbarService>(
    () => SnackbarService(),
  );
  locator.registerLazySingleton<ProfileService>(() => ProfileService());
  locator.registerLazySingleton<SignupService>(() => SignupService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  locator.registerLazySingleton<VideoPlayerService>(() => VideoPlayerService());

  await StorageService().init();
}
