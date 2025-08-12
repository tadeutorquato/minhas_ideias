import '../models/ideia_model.dart';
import '../services/hive_service.dart';

class IdeiaRepository {
  /// Salva uma nova ideia
  static Future<void> salvar(IdeiaModel ideia) async {
    await HiveService.salvarIdeia(ideia);
  }

  /// Obtém todas as ideias ordenadas por prioridade e data
  static List<IdeiaModel> obterTodas() {
    final ideias = HiveService.obterTodasIdeias();

    // Ordena por prioridade (maior primeiro) e depois por data (mais recente primeiro)
    ideias.sort((a, b) {
      final prioridadeComparison = b.prioridade.compareTo(a.prioridade);
      if (prioridadeComparison != 0) return prioridadeComparison;
      return b.dataCreacao.compareTo(a.dataCreacao);
    });

    return ideias;
  }

  /// Obtém uma ideia por ID
  static IdeiaModel? obterPorId(String id) {
    return HiveService.obterIdeiaPorId(id);
  }

  /// Atualiza uma ideia existente
  static Future<void> atualizar(IdeiaModel ideia) async {
    await HiveService.atualizarIdeia(ideia);
  }

  /// Remove uma ideia
  static Future<void> remover(String id) async {
    await HiveService.removerIdeia(id);
  }

  /// Remove todas as ideias
  static Future<void> limparTodas() async {
    await HiveService.limparTodasIdeias();
  }

  /// Obtém ideias por categoria
  static List<IdeiaModel> obterPorCategoria(String categoria) {
    final todasIdeias = obterTodas();
    return todasIdeias.where((ideia) => ideia.categoria == categoria).toList();
  }

  /// Obtém ideias por prioridade
  static List<IdeiaModel> obterPorPrioridade(int prioridade) {
    final todasIdeias = obterTodas();
    return todasIdeias.where((ideia) => ideia.prioridade == prioridade).toList();
  }

  /// Busca ideias por texto (título ou descrição)
  static List<IdeiaModel> buscar(String texto) {
    final todasIdeias = obterTodas();
    final textoLower = texto.toLowerCase();

    return todasIdeias
        .where((ideia) => ideia.titulo.toLowerCase().contains(textoLower) || ideia.descricao.toLowerCase().contains(textoLower))
        .toList();
  }

  /// Obtém estatísticas das ideias
  static Map<String, dynamic> obterEstatisticas() {
    final todasIdeias = obterTodas();

    final estatisticas = <String, dynamic>{'total': todasIdeias.length, 'categorias': <String, int>{}, 'prioridades': <int, int>{}};

    for (final ideia in todasIdeias) {
      // Conta por categoria
      estatisticas['categorias'][ideia.categoria] = (estatisticas['categorias'][ideia.categoria] ?? 0) + 1;

      // Conta por prioridade
      estatisticas['prioridades'][ideia.prioridade] = (estatisticas['prioridades'][ideia.prioridade] ?? 0) + 1;
    }

    return estatisticas;
  }
}
