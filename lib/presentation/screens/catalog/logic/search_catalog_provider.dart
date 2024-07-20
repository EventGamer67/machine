import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../logic/products_provider.dart';

final searchProductsProvider = FutureProvider<List<Product>>((ref) async {
  final filter = ref.watch(searchProductsFilterProvider);
  final res = await GetIt.I.get<Supabase>().client.from('Products').select('*').ilike('name', '%${filter.textFilter}%',  );
  return res.map((e)=>Product.fromMap(e)).toList();
});


final searchProductsFilterProvider = ChangeNotifierProvider<SearchProviderNotifier>((ref) {
  return SearchProviderNotifier();
});

class SearchProviderNotifier extends ChangeNotifier {
  String textFilter = '';

  update(){

  }

  updateSearchText(String text){
    textFilter = text;
    notifyListeners();
  }
}