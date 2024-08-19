class Gasto {
  int? id; // Llave primaria
  double monto;
  DateTime fecha;
  int cuentaId; // Llave foránea que referencia a la clase Cuenta
  int categoriaId; // Llave foránea que referencia a la clase Categoría
  String? descripcion;

  Gasto({
    this.id,
    required this.monto,
    required this.fecha,
    required this.cuentaId,
    required this.categoriaId,
    this.descripcion,
  });

  // Constructor para crear una instancia de Gasto a partir de un JSON
  Gasto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        monto = json['monto'],
        fecha = DateTime.parse(json['fecha']),
        cuentaId = json['cuentaId'],
        categoriaId = json['categoriaId'],
        descripcion = json['descripcion'];

  // Método para convertir la instancia de Gasto a JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['monto'] = monto;
    data['fecha'] = fecha.toIso8601String();
    data['cuentaId'] = cuentaId;
    data['categoriaId'] = categoriaId;
    data['descripcion'] = descripcion;
    return data;
  }
}