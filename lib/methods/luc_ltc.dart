import 'package:frontendapp/config/domain/entities/ltc.dart';
import 'package:frontendapp/config/domain/entities/luc.dart';
import 'package:frontendapp/config/domain/entities/recepcion.dart';

List<Luc> lUC(double costoorden, double costomanten, List<int> unidades) {
  List<Luc> luc = [];
  try {
    int b = 1;
    int c = 1;
    int d = 0;
    for (int a in unidades) {
      d += a;
      if (luc.isEmpty) {
        luc.add(Luc(
            Eliminar: false,
            periodos: b.toString(),
            unidadaes: a.toString(),
            s: costoorden,
            k: b * (b - 1) * costomanten,
            costoU: (((((b * (b - 1) * costomanten) + costoorden) / a) * 10000)
                        .round() /
                    10000)
                .toDouble(),
            costoT: (b * (b - 1) * costomanten) + costoorden));
      } else {
        luc.add(Luc(
            Eliminar: false,
            periodos: '${luc.last.periodos}+$b',
            unidadaes: '${luc.last.unidadaes}+$a',
            s: costoorden,
            k: ((c.toDouble() * (b.toDouble() - 1) * costomanten) * 100)
                    .round() /
                100,
            costoU:
                (((((c * (b - 1) * costomanten) + luc.last.costoT) / d) * 10000)
                        .round() /
                    10000),
            costoT: (((c * (b - 1) * costomanten) + luc.last.costoT) * 100)
                    .round() /
                100));
      }

      b += 1;
      c += b;
    }

    Luc? max = luc.isEmpty? null : luc[0];
    Luc? secondMax;

    for (var a in luc) {
      if (a.costoT > max!.costoT) {
        secondMax = max;
        max = a;
      } else if (secondMax == null || a.costoT > secondMax.costoT) {
        if (a.costoT != max.costoT) {
          secondMax = a;
        }
      }
    }

    for (int i = 0; i < luc.length; i++) {
      if (luc[i] == max || luc[i] == secondMax) {
        luc[i].Eliminar = true;
      }
    }

    return luc;
  } catch (e) {
    throw Exception("Ocurrio un error: $e");
  }
}

List<Recepcion> getRecepcionLuc(List<Luc> lucs, List<int> unidades){
  List<Recepcion> recepcions = [];
  int b= 1;
  for(int i = 0; i<unidades.length; i++){
    recepcions.add(Recepcion(periodo: b, requerimiento: unidades[i], recepcion: 
    lucs[i].Eliminar?lucs[i].costoT:0));
    b+=1;
  }
  return recepcions;
}

List<Ltc> lTC(double costoorden, double costomanten, List<int> unidades) {
  try {
    List<Ltc> ltcs = [];
    int b = 1;
    int c = 0;
    Ltc? ltc;
    for (int a in unidades) {
      ltc=ltcs.isEmpty?null:c==0?ltc:ltcs.last;
      ltcs.add(Ltc(
          periodos: b,
          unidadaes: a,
          periodoM: c,
          costoM: ((a * c * costomanten) * 100).round() / 100,
          costoMA: (ltcs.isEmpty
                      ? (a * c * costomanten)
                      : (a * c * costomanten == 0
                              ? 0
                              : ltcs.last.costoMA + (a * c * costomanten)) *
                          100)
                  .round() /
              100,
          eliminar: ltcs.isEmpty
              ? false
              : ((a * c * costomanten == 0
                          ? 0
                          : ltcs.last.costoMA + (a * c * costomanten)) >
                      costoorden
                  ? true
                  : false)));
      if (((ltc==null?0:ltc.costoMA) + (a * c * costomanten)) > costoorden) {
        c = 0;
        b = 1;
        ltc = null;
      } else {
        c += 1;
        b += 1;
      }
    }
    return ltcs;
  } catch (e) {
    throw Exception(e);
  }
}
List<Recepcion> getRecepcionLTC(List<Ltc> lucs, List<int> unidades){
  List<Recepcion> recepcions = [];
  int b= 1;
  for(int i = 0; i<unidades.length; i++){
    recepcions.add(Recepcion(periodo: b, requerimiento: unidades[i], recepcion: 
    lucs[i].eliminar?lucs[i].costoM:0));
    b+=1;
  }
  return recepcions;
}
