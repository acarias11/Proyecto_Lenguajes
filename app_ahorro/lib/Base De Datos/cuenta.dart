class Cuenta {
  int? id; // Llave primaria
  String userid;
  String nombre;
  String tipo;
  String moneda;
  bool cuentaCompleta = false;

  Cuenta({
    this.id,
    required this.nombre,
    required this.userid,
    required this.tipo,
    required this.moneda,
  });

  bool get isDataComplete {
    return nombre != nombre.isEmpty && tipo != tipo.isEmpty && moneda != moneda.isEmpty;
  }

  // Constructor para crear una instancia de Cuenta a partir de un JSON
  Cuenta.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userid = json['userID'],
        nombre = json['nombre'],
        tipo = json['tipo'],
        moneda = json['moneda'];

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
