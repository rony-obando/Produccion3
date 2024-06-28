import 'package:frontendapp/config/domain/entities/kanbanes.dart';

List<Kanbanes> getKanbanes(List<int> demandas, List<int> ofertas,
    List<double> tiempos, List<int> capacidades, double seguridad) {
  List<Kanbanes> kanbanes = [];

  int periodo = 0;
  for (int i = 0; i < demandas.length; i++) {
    periodo++;
    int kanbans = (((ofertas[i] - demandas[i]) * tiempos[i] * (1 + seguridad)) /
                capacidades[i])
            .round();
    kanbanes.add(Kanbanes(
        demanda: (ofertas[i] - demandas[i]),
        tiempoentrega: tiempos[i],
        seguridad: seguridad,
        capacidad: capacidades[i],
        kanbanes: kanbans<0?kanbans*-1:kanbans,
        periodo: periodo));
  }

  return kanbanes;
}

int totalKanbanes(List<Kanbanes> kns){
  int kanbanes = 0;
  for(var a in kns){
    kanbanes+=a.kanbanes;
  }
  return kanbanes;
}
