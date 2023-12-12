import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class BirthYearService with ReactiveServiceMixin {
  final RxValue<int?> _year = RxValue<int?>(null);
  final RxValue<DateTime?> _birthDate = RxValue<DateTime?>(null);

  BirthYearService() {
    listenToReactiveValues([_year,_birthDate]);
  }

  int? get year => _year.value;
  DateTime? get birthDate => _birthDate.value;

  void setYear(int? year){
    _year.value = year;
    notifyListeners();
  }

  void setBirthDate(DateTime? birthDate){
    _birthDate.value = birthDate;
    notifyListeners();
  }


  void clearBirthDate(){
    _year.value = null;
    _birthDate.value = null;
    notifyListeners();
  }
}