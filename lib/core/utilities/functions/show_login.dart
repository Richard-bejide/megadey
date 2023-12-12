import 'package:flutter/cupertino.dart';
import '../../services/utility_storage_service.dart';
import '../widgets/request_authentication_widget.dart';


void checkAuthStatus(Function() onPass, BuildContext context) async {
  if(StorageService().getBool('isLoggedIn') == true){
    onPass();
  }else{
    RequestAuthenticationModal(context);
  }
}