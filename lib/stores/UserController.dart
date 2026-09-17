import 'package:get/state_manager.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs; //user对象被监听了
  //想要取值的话，直接用user.value.属性名即可
  updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
