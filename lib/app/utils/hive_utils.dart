import '../models/ideia_model.dart';
import '../repositories/ideia_repository.dart';

/// Classe com métodos auxiliares para demonstrar funcionalidades do Hive
class HiveUtils {
  /// Gera dados de exemplo para testar o Hive
  static Future<void> gerarDadosExemplo() async {
    final ideias = [
      IdeiaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: 'Aplicativo de Meditação',
        descricao: 'Criar um app de meditação guiada com sons da natureza e técnicas de respiração.',
        dataCreacao: DateTime.now().subtract(const Duration(days: 10)),
        categoria: 'Pessoal',
        prioridade: 4,
      ),
      IdeiaModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        titulo: 'Sistema de Monitoramento de Plantas',
        descricao: 'Desenvolver um sistema IoT para monitorar umidade, temperatura e luz de plantas.',
        dataCreacao: DateTime.now().subtract(const Duration(days: 7)),
        categoria: 'Tecnologia',
        prioridade: 5,
      ),
      IdeiaModel(
        id: (DateTime.now().millisecondsSinceEpoch + 2).toString(),
        titulo: 'Curso Online de Fotografia',
        descricao: 'Criar um curso completo de fotografia digital para iniciantes.',
        dataCreacao: DateTime.now().subtract(const Duration(days: 3)),
        categoria: 'Criativo',
        prioridade: 3,
      ),
      IdeiaModel(
        id: (DateTime.now().millisecondsSinceEpoch + 3).toString(),
        titulo: 'Plataforma de Freelancers',
        descricao: 'Desenvolver uma plataforma para conectar freelancers com clientes.',
        dataCreacao: DateTime.now().subtract(const Duration(days: 1)),
        categoria: 'Negócios',
        prioridade: 5,
      ),
    ];

    for (final ideia in ideias) {
      await IdeiaRepository.salvar(ideia);
    }
  }

  /// Exporta todas as ideias para um formato JSON (para backup)
  static Map<String, dynamic> exportarParaJson() {
    final ideias = IdeiaRepository.obterTodas();
    return {
      'versao': '1.0',
      'dataExportacao': DateTime.now().toIso8601String(),
      'totalIdeias': ideias.length,
      'ideias': ideias.map((ideia) => ideia.toJson()).toList(),
    };
  }

  /// Importa ideias de um formato JSON (para restaurar backup)
  static Future<void> importarDeJson(Map<String, dynamic> dados) async {
    if (dados['ideias'] != null) {
      final List<dynamic> ideiasJson = dados['ideias'];

      for (final ideiaJson in ideiasJson) {
        try {
          final ideia = IdeiaModel.fromJson(ideiaJson);
          await IdeiaRepository.salvar(ideia);
        } catch (e) {
          print('Erro ao importar ideia: $e');
        }
      }
    }
  }

  /// Obtém estatísticas detalhadas das ideias
  static Map<String, dynamic> obterEstatisticasDetalhadas() {
    final estatisticas = IdeiaRepository.obterEstatisticas();
    final ideias = IdeiaRepository.obterTodas();

    // Calcula estatísticas adicionais
    if (ideias.isNotEmpty) {
      final datasMaisAntiga = ideias.map((i) => i.dataCreacao).reduce((a, b) => a.isBefore(b) ? a : b);
      final datasMaisRecente = ideias.map((i) => i.dataCreacao).reduce((a, b) => a.isAfter(b) ? a : b);
      final prioridadeMedia = ideias.map((i) => i.prioridade).reduce((a, b) => a + b) / ideias.length;

      estatisticas['datasMaisAntiga'] = datasMaisAntiga.toIso8601String();
      estatisticas['datasMaisRecente'] = datasMaisRecente.toIso8601String();
      estatisticas['prioridadeMedia'] = prioridadeMedia.toStringAsFixed(2);
      estatisticas['categoriaMaisPopular'] = _obterCategoriaMaisPopular(estatisticas['categorias']);
      estatisticas['prioridadeMaisComum'] = _obterPrioridadeMaisComum(estatisticas['prioridades']);
    }

    return estatisticas;
  }

  static String _obterCategoriaMaisPopular(Map<String, int> categorias) {
    if (categorias.isEmpty) return 'Nenhuma';

    String categoriaMaisPopular = categorias.keys.first;
    int maiorContagem = categorias.values.first;

    for (final entrada in categorias.entries) {
      if (entrada.value > maiorContagem) {
        maiorContagem = entrada.value;
        categoriaMaisPopular = entrada.key;
      }
    }

    return categoriaMaisPopular;
  }

  static int _obterPrioridadeMaisComum(Map<int, int> prioridades) {
    if (prioridades.isEmpty) return 0;

    int prioridadeMaisComum = prioridades.keys.first;
    int maiorContagem = prioridades.values.first;

    for (final entrada in prioridades.entries) {
      if (entrada.value > maiorContagem) {
        maiorContagem = entrada.value;
        prioridadeMaisComum = entrada.key;
      }
    }

    return prioridadeMaisComum;
  }

  /// Limpa e re-indexa o banco de dados
  static Future<void> otimizarBancoDados() async {
    final ideias = IdeiaRepository.obterTodas();

    // Limpa todos os dados
    await IdeiaRepository.limparTodas();

    // Re-salva todos os dados (isso reorganiza o banco)
    for (final ideia in ideias) {
      await IdeiaRepository.salvar(ideia);
    }
  }
}
