// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

shortPost _$shortPostFromJson(Map<String, dynamic> json) => shortPost(
      pid: json['pid'] as int,
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      address: json['address'] as String,
      disappearedAt: json['disappearedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      bookmarked: json['bookmarked'] as bool,
    );

Map<String, dynamic> _$shortPostToJson(shortPost instance) => <String, dynamic>{
      'pid': instance.pid,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'age': instance.age,
      'address': instance.address,
      'disappearedAt': instance.disappearedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bookmarked': instance.bookmarked,
    };