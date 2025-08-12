import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/sobre_view.dart';
import '../views/registro_ideia_view.dart';
import '../views/lista_ideias_view.dart';
import '../controllers/home_controller.dart';
import '../controllers/sobre_controller.dart';
import '../controllers/registro_ideia_controller.dart';
import '../controllers/lista_ideias_controller.dart';

class AppRoutes {
  static const String home = '/';
  static const String sobre = '/sobre';
  static const String registroIdeia = '/registro-ideia';
  static const String listaIdeias = '/lista-ideias';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: sobre,
      page: () => SobreView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SobreController>(() => SobreController());
      }),
    ),
    GetPage(
      name: registroIdeia,
      page: () => RegistroIdeiaView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegistroIdeiaController>(() => RegistroIdeiaController());
      }),
    ),
    GetPage(
      name: listaIdeias,
      page: () => ListaIdeiasView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ListaIdeiasController>(() => ListaIdeiasController());
      }),
    ),
  ];
}
