// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ideia_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdeiaModelAdapter extends TypeAdapter<IdeiaModel> {
  @override
  final int typeId = 0;

  @override
  IdeiaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdeiaModel(
      id: fields[0] as String,
      titulo: fields[1] as String,
      descricao: fields[2] as String,
      dataCreacao: fields[3] as DateTime,
      categoria: fields[4] as String,
      prioridade: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IdeiaModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.descricao)
      ..writeByte(3)
      ..write(obj.dataCreacao)
      ..writeByte(4)
      ..write(obj.categoria)
      ..writeByte(5)
      ..write(obj.prioridade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeiaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
