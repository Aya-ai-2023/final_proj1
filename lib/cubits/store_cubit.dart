
import 'package:final_proj/models/ad_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_proj/models/categ_model.dart';




class StoreCubit extends Cubit<Map<String, List<dynamic>>> {
  StoreCubit() : super({});

  void fetchData() async {
    try {
      // Fetch ads and categories
      final adsSnapshot = await FirebaseFirestore.instance.collection('ads').get();
      final categoriesSnapshot = await FirebaseFirestore.instance.collection('categories').get();

      final List<Ad> ads = adsSnapshot.docs.map((doc) {
        return Ad(id: doc.id, imageUrl: doc['imageUrl'], title: doc['title'], description: doc['description']);
      }).toList();

      final List<Category> categories = categoriesSnapshot.docs.map((doc) {
        return Category(id: doc.id, name: doc['name'], imageUrl: doc['imageUrl']);
      }).toList();

      emit({
        'ads': ads,
        'categories': categories,
      });
    } catch (e) {
      print('Error fetching ads and categories: $e');
    }
  }
}



