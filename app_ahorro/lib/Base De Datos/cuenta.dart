class Cuenta {
  int? id;
  String userid;
  String nombre;
  String tipo;
  String moneda;
  bool isDataComplete;

  // Constructor principal
  Cuenta({
    this.id,
    required this.userid,
    required this.nombre,
    required this.tipo,
    required this.moneda,
  }) : isDataComplete = nombre.isNotEmpty && tipo.isNotEmpty && moneda.isNotEmpty;

  // Constructor fromJson
  Cuenta.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userid = json['userID'],
        nombre = json['nombre'],
        tipo = json['tipo'],
        moneda = json['moneda'],
        isDataComplete = (json['nombre']?.isNotEmpty ?? false) &&
                         (json['tipo']?.isNotEmpty ?? false) &&
                         (json['moneda']?.isNotEmpty ?? false);

  // Método para convertir la instancia de Cuenta a JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userid;
    data['nombre'] = nombre;
    data['tipo'] = tipo;
    data['moneda'] = moneda;
    return data;
  }
}
