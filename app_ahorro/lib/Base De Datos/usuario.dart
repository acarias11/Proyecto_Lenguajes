class Usuario {
  int? id; // Llave primaria
  String userId;
  String nombre;
  String email;
  String contrasena;

  Usuario({
    this.id,
    required this.userId,
    required this.nombre,
    required this.email,
    required this.contrasena,
  });

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userID'],
        nombre = json['nombre'],
        email = json['email'],
        contrasena = json['contrasena'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userId;
    data['nombre'] = nombre;
    data['email'] = email;
    data['contrasena'] = contrasena;
    return data;
  }
}
