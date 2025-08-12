import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/ideia_model.dart';
import '../repositories/ideia_repository.dart';

class RegistroIdeiaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  final RxString selectedCategoria = 'Geral'.obs;
  final RxInt selectedPrioridade = 3.obs;
  final RxBool isLoading = false.obs;

  final List<String> categorias = ['Geral', 'Trabalho', 'Pessoal', 'Criativo', 'Tecnologia', 'Negócios', 'Estudo', 'Outros'];

  final List<Map<String, dynamic>> prioridades = [
    {'value': 1, 'label': '1 - Baixa', 'color': Colors.grey},
    {'value': 2, 'label': '2 - Baixa-Média', 'color': Colors.blue[300]},
    {'value': 3, 'label': '3 - Média', 'color': Colors.orange[300]},
    {'value': 4, 'label': '4 - Alta-Média', 'color': Colors.orange[600]},
    {'value': 5, 'label': '5 - Alta', 'color': Colors.red[400]},
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    tituloController.dispose();
    descricaoController.dispose();
    super.onClose();
  }

  void setCategoria(String categoria) {
    selectedCategoria.value = categoria;
  }

  void setPrioridade(int prioridade) {
    selectedPrioridade.value = prioridade;
  }

  String? validateTitulo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um título para a ideia';
    }
    if (value.length < 3) {
      return 'O título deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  String? validateDescricao(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma descrição para a ideia';
    }
    if (value.length < 10) {
      return 'A descrição deve ter pelo menos 10 caracteres';
    }
    return null;
  }

  Future<void> salvarIdeia() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      final ideia = IdeiaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: tituloController.text.trim(),
        descricao: descricaoController.text.trim(),
        dataCreacao: DateTime.now(),
        categoria: selectedCategoria.value,
        prioridade: selectedPrioridade.value,
      );

      // Salva a ideia usando o repositório
      await IdeiaRepository.salvar(ideia);

      Get.snackbar(
        'Sucesso!',
        'Ideia salva com sucesso',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      // Limpar o formulário
      limparFormulario();

      // Navegar para a lista de ideias
      Get.offNamed('/lista-ideias');
    } catch (e) {
      Get.snackbar(
        'Erro!',
        'Erro ao salvar a ideia: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void limparFormulario() {
    tituloController.clear();
    descricaoController.clear();
    selectedCategoria.value = 'Geral';
    selectedPrioridade.value = 3;
  }

  void goBack() {
    Get.back();
  }
}
