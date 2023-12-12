import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class LocationService with ReactiveServiceMixin {
  RxValue<double?> _locationLatitude = RxValue<double?>(null);
  RxValue<double?> _locationLongitude = RxValue<double?>(null);

  LocationService() {
    listenToReactiveValues([_locationLatitude, _locationLongitude]);
  }

  double? get locationLatitude => _locationLatitude.value;

  double? get locationLongitude => _locationLongitude.value;

  set setLatitude(double? latitude) => _locationLatitude.value = latitude;

  set setLongitude(double? longitude) => _locationLongitude.value = longitude;
}
