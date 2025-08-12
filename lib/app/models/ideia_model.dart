import 'package:hive/hive.dart';

part 'ideia_model.g.dart';

@HiveType(typeId: 0)
class IdeiaModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String titulo;

  @HiveField(2)
  final String descricao;

  @HiveField(3)
  final DateTime dataCreacao;

  @HiveField(4)
  final String categoria;

  @HiveField(5)
  final int prioridade; // 1-5 onde 5 é mais alta

  IdeiaModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataCreacao,
    required this.categoria,
    required this.prioridade,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataCreacao': dataCreacao.toIso8601String(),
      'categoria': categoria,
      'prioridade': prioridade,
    };
  }

  factory IdeiaModel.fromJson(Map<String, dynamic> json) {
    return IdeiaModel(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      dataCreacao: DateTime.parse(json['dataCreacao']),
      categoria: json['categoria'],
      prioridade: json['prioridade'],
    );
  }

  IdeiaModel copyWith({String? id, String? titulo, String? descricao, DateTime? dataCreacao, String? categoria, int? prioridade}) {
    return IdeiaModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      dataCreacao: dataCreacao ?? this.dataCreacao,
      categoria: categoria ?? this.categoria,
      prioridade: prioridade ?? this.prioridade,
    );
  }
}
