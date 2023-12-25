import 'package:final_proj/cubits/store_cubit.dart';
import 'package:final_proj/models/ad_model.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ad> adsData = context
        .select((StoreCubit cubit) => cubit.state['ads'] as List<Ad>? ?? []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.separated(
        itemCount: adsData.length,
        itemBuilder: (context, index) {
          late final category = adsData[index];
          return ListTile(
            title: Text(
              category.title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            leading: Image.network(category.imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
