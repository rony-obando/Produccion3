// ignore_for_file: file_names

class Componente {
  final int idComponente;
  final int cantidad;
  final String nombre;
  List<Componente> subcomponentes = [];

  Componente({required this.idComponente, required this.cantidad, required this.nombre,});

  factory Componente.fromJson(Map<String, dynamic> json) {
    return Componente(
      idComponente: json['IdComponente'],
      cantidad: json['cantidad'],
      nombre: json['nombre'],
    );
  }

  Componente cloneWithoutSubcomponents() {
    return Componente(
      idComponente: idComponente,
      nombre: nombre,
      cantidad: cantidad,
    );
  }
}
