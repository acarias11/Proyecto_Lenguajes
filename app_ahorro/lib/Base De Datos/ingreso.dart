class Ingreso {
  int? id; // Llave primaria
  double monto;
  DateTime fecha;
  int cuentaId; // Llave foránea que referencia a la clase Cuenta
  String descripcion;

  Ingreso({
    this.id,
    required this.monto,
    required this.fecha,
    required this.cuentaId,
    required this.descripcion,
  });

  Ingreso.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        monto = json['monto'],
        fecha = DateTime.parse(json['fecha']),
        cuentaId = json['cuentaId'],
        descripcion = json['descripcion'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['monto'] = monto;
    data['fecha'] = fecha.toIso8601String();
    data['cuentaId'] = cuentaId;
    data['descripcion'] = descripcion;
    return data;
  }
}
