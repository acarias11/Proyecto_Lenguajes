class Moneda {
  int? id; // Llave primaria
  String nombre;
  String simbolo;

  Moneda({
    this.id,
    required this.nombre,
    required this.simbolo,
  });

  Moneda.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        simbolo = json['simbolo'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['simbolo'] = simbolo;
    return data;
  }
}
