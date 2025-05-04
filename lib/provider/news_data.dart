import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/model/news_model.dart';

class NewsFsProviderNotifier extends StateNotifier<List<NewsModel>> {
  NewsFsProviderNotifier() : super([]);

  void newsData() async {
    final fsRef =
        await FirebaseFirestore.instance.collection('News').limit(5).get();
    final newsData = fsRef.docs;

    final newsDataList =
        newsData.map((e) => NewsModel.fromJson(e.data())).toList();

    state = newsDataList;
  }
}

final newsFSProvider =
    StateNotifierProvider<NewsFsProviderNotifier, List<NewsModel>>((ref) {
  return NewsFsProviderNotifier();
});
