import 'package:supabase_flutter/supabase_flutter.dart';

class Supabasecredentials{
  static const String ApiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvc25rdXR4aWl6aHVtb2xxcnhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM5ODk1MTQsImV4cCI6MjAyOTU2NTUxNH0.VY1kdn2ULW84WheJZbS96qWThzzk96a3ef6F8a-e4h0";
  static const String ApiUrl  = "https://posnkutxiizhumolqrxo.supabase.co";

  static SupabaseClient supabaseClient = SupabaseClient(
    ApiUrl,
    ApiKey
  );


}
