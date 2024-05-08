// ignore_for_file: file_names

class Producto {
  final int idProducto;
  final int cantidad;
  final String nombre;

  Producto({required this.idProducto, required this.cantidad, required this.nombre});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['id'],
      cantidad: json['cantidad'],
      nombre: json['nombre'],
    );
  }
}
