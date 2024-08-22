class Ahorro {
  int? id; // Llave primaria
  double monto;
  DateTime fecha;
  String? cuentaId; // Llave foránea que referencia a la clase Cuenta
  String descripcion;

  Ahorro({
    this.id,
    required this.monto,
    required this.fecha,
     this.cuentaId,
    required this.descripcion,
  });

  Ahorro.fromJson(Map<String, dynamic> json)
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
