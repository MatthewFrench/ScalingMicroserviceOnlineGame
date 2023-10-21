// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library my_game.sample;

import 'dart:typed_data' show Uint8List;
import 'package:flat_buffers/flat_buffers.dart' as fb;


class Color {
  final int value;
  const Color._(this.value);

  factory Color.fromValue(int value) {
    final result = values[value];
    if (result == null) {
        throw StateError('Invalid value $value for bit flag enum Color');
    }
    return result;
  }

  static Color? _createOrNull(int? value) => 
      value == null ? null : Color.fromValue(value);

  static const int minValue = 0;
  static const int maxValue = 2;
  static bool containsValue(int value) => values.containsKey(value);

  static const Color Red = Color._(0);
  static const Color Green = Color._(1);
  static const Color Blue = Color._(2);
  static const Map<int, Color> values = {
    0: Red,
    1: Green,
    2: Blue};

  static const fb.Reader<Color> reader = _ColorReader();

  @override
  String toString() {
    return 'Color{value: $value}';
  }
}

class _ColorReader extends fb.Reader<Color> {
  const _ColorReader();

  @override
  int get size => 1;

  @override
  Color read(fb.BufferContext bc, int offset) =>
      Color.fromValue(const fb.Int8Reader().read(bc, offset));
}

class EquipmentTypeId {
  final int value;
  const EquipmentTypeId._(this.value);

  factory EquipmentTypeId.fromValue(int value) {
    final result = values[value];
    if (result == null) {
        throw StateError('Invalid value $value for bit flag enum EquipmentTypeId');
    }
    return result;
  }

  static EquipmentTypeId? _createOrNull(int? value) => 
      value == null ? null : EquipmentTypeId.fromValue(value);

  static const int minValue = 0;
  static const int maxValue = 1;
  static bool containsValue(int value) => values.containsKey(value);

  static const EquipmentTypeId NONE = EquipmentTypeId._(0);
  static const EquipmentTypeId Weapon = EquipmentTypeId._(1);
  static const Map<int, EquipmentTypeId> values = {
    0: NONE,
    1: Weapon};

  static const fb.Reader<EquipmentTypeId> reader = _EquipmentTypeIdReader();

  @override
  String toString() {
    return 'EquipmentTypeId{value: $value}';
  }
}

class _EquipmentTypeIdReader extends fb.Reader<EquipmentTypeId> {
  const _EquipmentTypeIdReader();

  @override
  int get size => 1;

  @override
  EquipmentTypeId read(fb.BufferContext bc, int offset) =>
      EquipmentTypeId.fromValue(const fb.Uint8Reader().read(bc, offset));
}

class Vec3 {
  Vec3._(this._bc, this._bcOffset);

  static const fb.Reader<Vec3> reader = _Vec3Reader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  double get x => const fb.Float32Reader().read(_bc, _bcOffset + 0);
  double get y => const fb.Float32Reader().read(_bc, _bcOffset + 4);
  double get z => const fb.Float32Reader().read(_bc, _bcOffset + 8);

  @override
  String toString() {
    return 'Vec3{x: ${x}, y: ${y}, z: ${z}}';
  }
}

class _Vec3Reader extends fb.StructReader<Vec3> {
  const _Vec3Reader();

  @override
  int get size => 12;

  @override
  Vec3 createObject(fb.BufferContext bc, int offset) => 
    Vec3._(bc, offset);
}

class Vec3Builder {
  Vec3Builder(this.fbBuilder);

  final fb.Builder fbBuilder;

  int finish(double x, double y, double z) {
    fbBuilder.putFloat32(z);
    fbBuilder.putFloat32(y);
    fbBuilder.putFloat32(x);
    return fbBuilder.offset;
  }

}

class Vec3ObjectBuilder extends fb.ObjectBuilder {
  final double _x;
  final double _y;
  final double _z;

  Vec3ObjectBuilder({
    required double x,
    required double y,
    required double z,
  })
      : _x = x,
        _y = y,
        _z = z;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    fbBuilder.putFloat32(_z);
    fbBuilder.putFloat32(_y);
    fbBuilder.putFloat32(_x);
    return fbBuilder.offset;
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}
class Monster {
  Monster._(this._bc, this._bcOffset);
  factory Monster(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<Monster> reader = _MonsterReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  Vec3? get pos => Vec3.reader.vTableGetNullable(_bc, _bcOffset, 4);
  int get mana => const fb.Int16Reader().vTableGet(_bc, _bcOffset, 6, 150);
  int get hp => const fb.Int16Reader().vTableGet(_bc, _bcOffset, 8, 100);
  String? get name => const fb.StringReader().vTableGetNullable(_bc, _bcOffset, 10);
  List<int>? get inventory => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 14);
  Color get color => Color.fromValue(const fb.Int8Reader().vTableGet(_bc, _bcOffset, 16, 2));
  List<Weapon>? get weapons => const fb.ListReader<Weapon>(Weapon.reader).vTableGetNullable(_bc, _bcOffset, 18);
  EquipmentTypeId? get equippedType => EquipmentTypeId._createOrNull(const fb.Uint8Reader().vTableGetNullable(_bc, _bcOffset, 20));
  dynamic get equipped {
    switch (equippedType?.value) {
      case 1: return Weapon.reader.vTableGetNullable(_bc, _bcOffset, 22);
      default: return null;
    }
  }
  List<Vec3>? get path => const fb.ListReader<Vec3>(Vec3.reader).vTableGetNullable(_bc, _bcOffset, 24);

  @override
  String toString() {
    return 'Monster{pos: ${pos}, mana: ${mana}, hp: ${hp}, name: ${name}, inventory: ${inventory}, color: ${color}, weapons: ${weapons}, equippedType: ${equippedType}, equipped: ${equipped}, path: ${path}}';
  }
}

class _MonsterReader extends fb.TableReader<Monster> {
  const _MonsterReader();

  @override
  Monster createObject(fb.BufferContext bc, int offset) => 
    Monster._(bc, offset);
}

class MonsterBuilder {
  MonsterBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(11);
  }

  int addPos(int offset) {
    fbBuilder.addStruct(0, offset);
    return fbBuilder.offset;
  }
  int addMana(int? mana) {
    fbBuilder.addInt16(1, mana);
    return fbBuilder.offset;
  }
  int addHp(int? hp) {
    fbBuilder.addInt16(2, hp);
    return fbBuilder.offset;
  }
  int addNameOffset(int? offset) {
    fbBuilder.addOffset(3, offset);
    return fbBuilder.offset;
  }
  int addInventoryOffset(int? offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }
  int addColor(Color? color) {
    fbBuilder.addInt8(6, color?.value);
    return fbBuilder.offset;
  }
  int addWeaponsOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }
  int addEquippedType(EquipmentTypeId? equippedType) {
    fbBuilder.addUint8(8, equippedType?.value);
    return fbBuilder.offset;
  }
  int addEquippedOffset(int? offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }
  int addPathOffset(int? offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class MonsterObjectBuilder extends fb.ObjectBuilder {
  final Vec3ObjectBuilder? _pos;
  final int? _mana;
  final int? _hp;
  final String? _name;
  final List<int>? _inventory;
  final Color? _color;
  final List<WeaponObjectBuilder>? _weapons;
  final EquipmentTypeId? _equippedType;
  final dynamic _equipped;
  final List<Vec3ObjectBuilder>? _path;

  MonsterObjectBuilder({
    Vec3ObjectBuilder? pos,
    int? mana,
    int? hp,
    String? name,
    List<int>? inventory,
    Color? color,
    List<WeaponObjectBuilder>? weapons,
    EquipmentTypeId? equippedType,
    dynamic equipped,
    List<Vec3ObjectBuilder>? path,
  })
      : _pos = pos,
        _mana = mana,
        _hp = hp,
        _name = name,
        _inventory = inventory,
        _color = color,
        _weapons = weapons,
        _equippedType = equippedType,
        _equipped = equipped,
        _path = path;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? nameOffset = _name == null ? null
        : fbBuilder.writeString(_name!);
    final int? inventoryOffset = _inventory == null ? null
        : fbBuilder.writeListUint8(_inventory!);
    final int? weaponsOffset = _weapons == null ? null
        : fbBuilder.writeList(_weapons!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    final int? equippedOffset = _equipped?.getOrCreateOffset(fbBuilder);
    final int? pathOffset = _path == null ? null
        : fbBuilder.writeListOfStructs(_path!);
    fbBuilder.startTable(11);
    if (_pos != null) {
      fbBuilder.addStruct(0, _pos!.finish(fbBuilder));
    }
    fbBuilder.addInt16(1, _mana);
    fbBuilder.addInt16(2, _hp);
    fbBuilder.addOffset(3, nameOffset);
    fbBuilder.addOffset(5, inventoryOffset);
    fbBuilder.addInt8(6, _color?.value);
    fbBuilder.addOffset(7, weaponsOffset);
    fbBuilder.addUint8(8, _equippedType?.value);
    fbBuilder.addOffset(9, equippedOffset);
    fbBuilder.addOffset(10, pathOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}
class Weapon {
  Weapon._(this._bc, this._bcOffset);
  factory Weapon(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<Weapon> reader = _WeaponReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  String? get name => const fb.StringReader().vTableGetNullable(_bc, _bcOffset, 4);
  int get damage => const fb.Int16Reader().vTableGet(_bc, _bcOffset, 6, 0);

  @override
  String toString() {
    return 'Weapon{name: ${name}, damage: ${damage}}';
  }
}

class _WeaponReader extends fb.TableReader<Weapon> {
  const _WeaponReader();

  @override
  Weapon createObject(fb.BufferContext bc, int offset) => 
    Weapon._(bc, offset);
}

class WeaponBuilder {
  WeaponBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(2);
  }

  int addNameOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }
  int addDamage(int? damage) {
    fbBuilder.addInt16(1, damage);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class WeaponObjectBuilder extends fb.ObjectBuilder {
  final String? _name;
  final int? _damage;

  WeaponObjectBuilder({
    String? name,
    int? damage,
  })
      : _name = name,
        _damage = damage;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? nameOffset = _name == null ? null
        : fbBuilder.writeString(_name!);
    fbBuilder.startTable(2);
    fbBuilder.addOffset(0, nameOffset);
    fbBuilder.addInt16(1, _damage);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}
