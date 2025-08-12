import 'package:get/get.dart';

class SobreController extends GetxController {
  final RxString appVersion = '1.0.0'.obs;
  final RxString appDescription = 'Um aplicativo elegante para registrar e organizar suas ideias criativas.'.obs;
  final RxString developerName = 'Desenvolvido com ❤️'.obs;

  final List<Map<String, String>> features = [
    {'title': 'Registro Simples', 'description': 'Interface intuitiva para registrar suas ideias rapidamente'},
    {'title': 'Organização Inteligente', 'description': 'Categorize e priorize suas ideias de forma eficiente'},
    {'title': 'Design Elegante', 'description': 'Interface moderna e profissional para uma melhor experiência'},
    {'title': 'Acesso Rápido', 'description': 'Encontre suas ideias facilmente com nossa lista organizada'},
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void goBack() {
    Get.back();
  }
}
