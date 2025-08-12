import 'package:get/get.dart';
import '../models/ideia_model.dart';
import '../repositories/ideia_repository.dart';

class ListaIdeiasController extends GetxController {
  final RxList<IdeiaModel> ideias = <IdeiaModel>[].obs;
  final RxList<IdeiaModel> ideiasFiltered = <IdeiaModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'Todas'.obs;
  final RxBool isLoading = false.obs;

  final List<String> filtros = ['Todas', 'Geral', 'Trabalho', 'Pessoal', 'Criativo', 'Tecnologia', 'Negócios', 'Estudo', 'Outros'];

  @override
  void onInit() {
    super.onInit();
    carregarIdeias();
  }

  Future<void> carregarIdeias() async {
    isLoading.value = true;

    try {
      // Carrega as ideias do repositório
      final List<IdeiaModel> ideiasCarregadas = IdeiaRepository.obterTodas();

      // Simplesmente carrega as ideias salvas (sem dados de exemplo)
      ideias.value = ideiasCarregadas;

      applyFilter();
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao carregar ideias: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void applyFilter() {
    List<IdeiaModel> filtered =
        ideias.where((ideia) {
          final matchesSearch =
              searchQuery.value.isEmpty ||
              ideia.titulo.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              ideia.descricao.toLowerCase().contains(searchQuery.value.toLowerCase());

          final matchesFilter = selectedFilter.value == 'Todas' || ideia.categoria == selectedFilter.value;

          return matchesSearch && matchesFilter;
        }).toList();

    // Ordenar por prioridade (maior primeiro) e depois por data (mais recente primeiro)
    filtered.sort((a, b) {
      final prioridadeComparison = b.prioridade.compareTo(a.prioridade);
      if (prioridadeComparison != 0) return prioridadeComparison;
      return b.dataCreacao.compareTo(a.dataCreacao);
    });

    ideiasFiltered.value = filtered;
  }

  Future<void> deleteIdeia(String id) async {
    try {
      // Remove usando o repositório
      await IdeiaRepository.remover(id);

      // Remove da lista local
      ideias.removeWhere((ideia) => ideia.id == id);
      applyFilter();

      Get.snackbar('Sucesso!', 'Ideia removida com sucesso', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao remover ideia: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> atualizarIdeia(IdeiaModel ideiaAtualizada) async {
    try {
      // Atualiza usando o repositório
      await IdeiaRepository.atualizar(ideiaAtualizada);

      // Atualiza na lista local
      final index = ideias.indexWhere((ideia) => ideia.id == ideiaAtualizada.id);
      if (index != -1) {
        ideias[index] = ideiaAtualizada;
        applyFilter();
      }

      Get.snackbar('Sucesso!', 'Ideia atualizada com sucesso', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao atualizar ideia: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> limparTodasIdeias() async {
    try {
      await IdeiaRepository.limparTodas();
      ideias.clear();
      applyFilter();
      Get.snackbar('Sucesso!', 'Todas as ideias foram removidas', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao limpar ideias: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void navigateToRegistroIdeia() {
    Get.toNamed('/registro-ideia');
  }

  void goBack() {
    Get.back();
  }
}
