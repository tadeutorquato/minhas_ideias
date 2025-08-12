import 'package:hive_flutter/hive_flutter.dart';
import '../models/ideia_model.dart';

class HiveService {
  static const String _ideiaBoxName = 'ideias';
  static Box<IdeiaModel>? _ideiaBox;

  /// Inicializa o Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Registra o adapter para IdeiaModel
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(IdeiaModelAdapter());
    }

    // Abre a box de ideias
    _ideiaBox = await Hive.openBox<IdeiaModel>(_ideiaBoxName);
  }

  /// Obtém a box de ideias
  static Box<IdeiaModel> get ideiaBox {
    if (_ideiaBox == null || !_ideiaBox!.isOpen) {
      throw Exception('Hive não foi inicializado ou a box não está aberta');
    }
    return _ideiaBox!;
  }

  /// Salva uma nova ideia
  static Future<void> salvarIdeia(IdeiaModel ideia) async {
    await ideiaBox.put(ideia.id, ideia);
  }

  /// Obtém todas as ideias
  static List<IdeiaModel> obterTodasIdeias() {
    return ideiaBox.values.toList();
  }

  /// Obtém uma ideia por ID
  static IdeiaModel? obterIdeiaPorId(String id) {
    return ideiaBox.get(id);
  }

  /// Atualiza uma ideia existente
  static Future<void> atualizarIdeia(IdeiaModel ideia) async {
    await ideiaBox.put(ideia.id, ideia);
  }

  /// Remove uma ideia
  static Future<void> removerIdeia(String id) async {
    await ideiaBox.delete(id);
  }

  /// Remove todas as ideias
  static Future<void> limparTodasIdeias() async {
    await ideiaBox.clear();
  }

  /// Fecha as boxes do Hive
  static Future<void> close() async {
    await _ideiaBox?.close();
  }
}
