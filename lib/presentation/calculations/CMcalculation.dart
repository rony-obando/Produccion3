import 'dart:math';

// ignore_for_file: file_names
// ignore: non_constant_identifier_names
double numero_fallas(int horasmantenimiento,double mtbf){
  if(mtbf == 0.0){
        throw Exception('El mtbf no puede ser cero');
      }
 return (horasmantenimiento.toDouble()/mtbf).round()==0? 1: (horasmantenimiento.toDouble()/mtbf).round().toDouble();
}

// ignore: non_constant_identifier_names
double Calcular_Resultado(
    double numerofallas,
    double duraciontarea,
    double costohoratrabajo,
    double respuestos,
    double costooperacionales,
    double retrasologistico,
    double costoparada,
    double costofallaunica,
    double resultado,) {
      if(numerofallas == 0){
        throw Exception('El número de fallas no puede ser cero');
      }
  return numerofallas *
      ((duraciontarea * costohoratrabajo + respuestos + costooperacionales+retrasologistico) +
          (duraciontarea * costoparada + costofallaunica));
}

// ignore: non_constant_identifier_names
int Calcular_EOQ(double demanda, double costopedidos, double costomantenimiento,
    int periodo) {
  if (costomantenimiento == 0.0) {
    throw Exception('El Costo de mantenimiento no puede ser cero');
  }
  double p = sqrt((2 * demanda * periodo * costopedidos) / costomantenimiento);
  return p.round();
}

// ignore: non_constant_identifier_names
int inventory_rotation(int demanda, int ss, int ciclo, int cantidadpedida,bool fijo){
  int rotacion = 0;
  double invpromedio = 0;
  if(fijo){
    invpromedio = cantidadpedida/2 + ss;
    
  }else{
    invpromedio = ciclo*demanda/2 + ss;
  }
  rotacion = (demanda / invpromedio).round();
  return rotacion==0?1:rotacion;
}

int cantidad_recipientes(int demanda, int tamano, double tiempo){
  return ((demanda*tiempo)/(60*tamano)).round();
}