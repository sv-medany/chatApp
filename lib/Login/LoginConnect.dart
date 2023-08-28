import '../Models/MyUser.dart';

abstract class LoginConnect{
  void showLoading();
  void hideLoading();
  void NavigateToHome(MyUser? user);
  void showMessage(String message);
}