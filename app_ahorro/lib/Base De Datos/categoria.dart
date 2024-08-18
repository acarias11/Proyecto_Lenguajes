class Categoria {
  int? id; // Llave primaria
  String nombre;
  String tipo;

  Categoria({
    this.id,
    required this.nombre,
    required this.tipo,
  });

  // Constructor para crear una instancia de Categoria a partir de un JSON
  Categoria.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        tipo = json['tipo'];

  // Método para convertir la instancia de Categoria a JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['tipo'] = tipo;
    return data;
  }
}
