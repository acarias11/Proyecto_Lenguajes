class Usuario {
  int? id; // Llave primaria
  String nombre;
  String email;
  String contrasena;

  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.contrasena,
  });

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        email = json['email'],
        contrasena = json['contrasena'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['email'] = email;
    data['contrasena'] = contrasena;
    return data;
  }
}
