class Union{
  final int id;
  final int idHijo;
  final int idPadre;
  final int CantidadHijo;
  final bool PadreEsProducto;
  final String idUsuario;

  Union({required this.id, required this.idHijo, required this.idPadre, required this.CantidadHijo, required this.PadreEsProducto, required this.idUsuario});

  factory Union.fromJson(Map<String, dynamic> json){
    return Union(
    id: json['id'], 
    idHijo: json['idHijo'], 
    idPadre: json['idPadre'], 
    CantidadHijo: json['CantidadHijo'],
    idUsuario: json['IdUsuario'], 
    PadreEsProducto: json['PadreEsProducto']);
  }


}