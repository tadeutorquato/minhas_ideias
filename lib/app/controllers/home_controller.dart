import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString appTitle = 'Minhas Ideias'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void navigateToRegistroIdeia() {
    Get.toNamed('/registro-ideia');
  }

  void navigateToListaIdeias() {
    Get.toNamed('/lista-ideias');
  }

  void navigateToSobre() {
    Get.toNamed('/sobre');
  }
}
