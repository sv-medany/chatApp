import '../Models/MyUser.dart';

abstract class RegisterConnect{
  void showLoading();
  void hideLoading();
  void NavigateToHome(MyUser? user);
  void showMessage(String message);
}