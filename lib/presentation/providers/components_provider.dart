import 'package:flutter/material.dart';
import 'package:frontendapp/config/domain/entities/Componente.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ComponentsProvider extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;
  List<Map<String, dynamic>> componentes = [];
  bool isLoading = false;
  List<Componente> comps = [];

  ComponentsProvider() {
    fetchComponents();
  }

  final TransformationController transformationController =
      TransformationController();


  Future<void> fetchComponents() async {
    isLoading = true;
    notifyListeners();
    try {

      final responsecomponente = await client.from('Componente').select();


      componentes = List<Map<String, dynamic>>.from(responsecomponente);

      final data = responsecomponente as List;
      comps = data.map((json) => Componente.fromJson(json)).toList();

    } catch (e) {}
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteComponetns(int id) async {
    final response = await client.from('Componente').delete().match({'IdComponente': id});
    if (response == null) {
      fetchComponents();
    } else {
      notifyListeners();
    }
  }

  Future<void> updateComponents(int id, String nombre, int cantidad) async {
    final response = await client
        .from('Componente')
        .update({'nombre': nombre, 'cantidad': cantidad}).match({'IdComponente': id});
    if (response == null) {
      fetchComponents();
    } else {
      notifyListeners();
    }
  }


  Future<void> addComponent(String nombre, int cantidad) async {
    final response = await client
        .from('Componente')
        .insert({'nombre': nombre, 'cantidad': cantidad});
    if (response == null) {
      fetchComponents();
    } else {
      notifyListeners();
    }
  }


}
