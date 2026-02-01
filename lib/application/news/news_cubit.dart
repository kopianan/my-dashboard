import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/domain/repositories/news_repository.dart';
import 'package:dynamic_dashboard/domain/entities/news.dart';

part 'news_state.dart';
part 'news_cubit.freezed.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  
  NewsCubit(this.newsRepository) : super(const NewsState.initial());
  
  Future<void> getTopHeadlines({
    String country = 'us',
    int pageSize = 2,
  }) async {
    emit(const NewsState.loading());
    
    final result = await newsRepository.getTopHeadlines(
      country: country,
      pageSize: pageSize,
    );
    
    result.fold(
      (error) => emit(NewsState.error(error)),
      (newsResponse) => emit(NewsState.loaded(newsResponse)),
    );
  }
}
