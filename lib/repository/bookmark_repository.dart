import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'bookmark_repository.g.dart';

@RestApi()
abstract class BookmarkRepository {
  factory BookmarkRepository(Dio dio, {String baseUrl}) = _BookmarkRepository;
  
  @POST('/bookmarks/{id}')
  Future postBookmark(@Path() int id);

  @POST('/bookmarks/{id}')
  Future deleteBookmark(@Path() int id);
}