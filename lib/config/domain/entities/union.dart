class Union{
  final int id;
  final int idHijo;
  final int idPadre;
  final int CantidadHijo;
  final bool PadreEsProducto;

  Union({required this.id, required this.idHijo, required this.idPadre, required this.CantidadHijo, required this.PadreEsProducto});

  factory Union.fromJson(Map<String, dynamic> json){
    return Union(
    id: json['id'], 
    idHijo: json['idHijo'], 
    idPadre: json['idPadre'], 
    CantidadHijo: json['CantidadHijo'], 
    PadreEsProducto: json['PadreEsProducto']);
  }


}