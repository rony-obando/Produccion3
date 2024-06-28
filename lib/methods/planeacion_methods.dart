
import 'package:frontendapp/config/domain/entities/Planeacion.dart';

List<Planeacion> getPlaneacions(int meses, List<String> nombres, List<int> demandas, List<int> diasProduccion){

  List<Planeacion> planeacions = [];

  for(int i = 0; i<meses; i++){
    planeacions.add(Planeacion(mes: nombres[i], demanda: demandas[i], dias: diasProduccion[i], demandaxdia: (demandas[i]/diasProduccion[i]).round()));
  }

  return planeacions;

}