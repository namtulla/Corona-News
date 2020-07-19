/*
 * Copyright (c) 2020, Kanan Yusubov. - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 * Written by: Kanan Yusubov <kanan.yusub@gmail.com>, July 2020
 */

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/models/news.dart';
import 'package:cubit/cubit.dart';
import '../../data/contractors/impl_news_repository.dart';
import '../../data/exceptions/http_exception.dart';

part './news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.newsRepository)
      : assert(newsRepository != null),
        super(NewsInitial());

  final INewsRepository newsRepository;

  void getAllNews() async {
    try {
      emit(NewsInProgress());
      final news = await newsRepository.getAllNews();
      emit(NewsSuccess(news));
    } on HttpException catch (e) {
      emit(NewsFailure(e.message));
    } catch (e) {
      emit(NewsFailure(e.toString()));
    }
  }
}