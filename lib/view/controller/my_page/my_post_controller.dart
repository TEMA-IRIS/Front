import 'package:get/get.dart';
import 'package:iris_flutter/model/short_post.dart';

class MyPostController extends GetxController {
  RxList<ShortPost> postList = <ShortPost>[].obs;
  void loadData() {
    List<ShortPost> tmpData = [
      ShortPost(
          pid: 1,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '김마이',
          age: 85,
          latitude: 37.546176,
          longitude: 126.962722,
          gender: false,
          address: '테스트시 용산구 갈월동',
          bookmarked: false,
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null),
      ShortPost(
          pid: 2,
          imgUrl:
              'https://cdn.class101.net/images/587ecdf0-4329-4447-ac00-f2b25b23eab8',
          name: '김페이',
          age: 7,
          gender: true,
          address: '테스트시 용산구 왕왕동',
          latitude: 37.545176,
          longitude: 126.964722,
          disappearedAt: "2024-02-12 22:57:05.427963",
          createdAt: "2024-02-12 22:57:05.427963",
          updatedAt: null,
          bookmarked: true),
      ShortPost(
          pid: 3,
          imgUrl:
              'https://blenderartists.org/uploads/default/original/4X/5/4/f/54f2cbb9c456be76911967e686ca5898ac6a065d.jpeg',
          name: '홍지',
          age: 9,
          gender: false,
          latitude: 37.546276,
          longitude: 126.964722,
          address: '테스트시 용산구 왕왕동',
          disappearedAt: "2024-02-09T07:11:42.069Z",
          createdAt: "2024-02-09T07:11:42.069Z",
          updatedAt: null,
          bookmarked: true),
    ];

    postList.value = tmpData;
  }
}
