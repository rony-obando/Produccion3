// ignore_for_file: file_names

class Producto {
  final int idProducto;
  final int cantidad;
  final String nombre;
  final String idUsuario;

  Producto({required this.idProducto, required this.cantidad, required this.nombre, required this.idUsuario});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['id'],
      cantidad: json['cantidad'],
      nombre: json['nombre'],
      idUsuario: json['IdUsuario']
    );
  }
}
