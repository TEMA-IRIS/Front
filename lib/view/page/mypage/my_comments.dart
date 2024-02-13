import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/my_comments_response.dart';
import 'package:iris_flutter/utils/conversion_utils.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/mypage/my_comments_controller.dart';
import 'package:iris_flutter/view/page/detail_info/post_page.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MyComments extends StatefulWidget {
  const MyComments({super.key});

  @override
  State<MyComments> createState() => _MyCommentsState();
}

class _MyCommentsState extends State<MyComments> {
  MyCommentsController comtController = Get.put(MyCommentsController());
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    comtController.loadData();
  }

  void galleryPageChange(int index) {
    comtController.changeImgSlideIdx(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "작성한 제보 댓글"),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: comtController.commentsList.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  itemCount: comtController.commentsList.length,
                  itemBuilder: (BuildContext context, int postIdx) {
                    final missingInfo = comtController.commentsList[postIdx];
                    return Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () => Get.to(const PostPage()),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      missingInfo.imgUrl,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Padding(padding: CustomPadding.slimRight),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Text(
                                      '${missingInfo.name} / ${missingInfo.gender ? "남" : "여"} / ${missingInfo.age} 세 / ${missingInfo.address}',
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.basic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          itemCount: missingInfo.commentList.length,
                          itemBuilder: (BuildContext context, int cmtIdx) {
                            return commentItem(missingInfo, cmtIdx, context,
                                pageController, galleryPageChange);
                          },
                          separatorBuilder: (BuildContext ctx, int idx) {
                            return const Divider();
                          },
                        ),
                      ],
                    );
                  })
              : const Center(
                  child: Text("작성한 제보 댓글이 없습니다."),
                )),
    );
  }

  Padding commentItem(
      MyCommentsResp missingInfo,
      int cmtIdx,
      BuildContext context,
      PageController pageController,
      void Function(int index) galleryPageChange) {
    return Padding(
      padding: CustomPadding.pageInsets,
      child: Column(
        children: [
          // 제목
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  missingInfo.commentList[cmtIdx].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(convertDateString(missingInfo.commentList[cmtIdx].createdAt),
                  style: const TextStyle(fontSize: 12))
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          // 내용
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  // 이미지(썸네일)
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => imgDialog(
                              missingInfo,
                              cmtIdx,
                              pageController,
                              galleryPageChange,
                              context),
                        ),
                        child: Image.network(
                            missingInfo.commentList[cmtIdx].images[0],
                            fit: BoxFit.cover),
                      ))),
              const SizedBox(width: 12),
              if (missingInfo.commentList[cmtIdx].clothes != null &&
                  missingInfo.commentList[cmtIdx].details != null)
                Expanded(
                  // 상세 정보 글
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (missingInfo.commentList[cmtIdx].clothes != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("옷차림",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                child: Text(
                                    missingInfo.commentList[cmtIdx].clothes!))
                          ],
                        ),
                      if (missingInfo.commentList[cmtIdx].details != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("당시 상황",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                child: Text(
                                    missingInfo.commentList[cmtIdx].details!))
                          ],
                        ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text('일치율 ${missingInfo.commentList[cmtIdx].accuracy} %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary))
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Dialog imgDialog(
      MyCommentsResp missingInfo,
      int cmtIdx,
      PageController pageController,
      void Function(int index) galleryPageChange,
      BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              final item = missingInfo.commentList[cmtIdx].images[index];
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale:
                      PhotoViewComputedScale.contained * (0.5 + index / 10),
                  maxScale: PhotoViewComputedScale.contained * 1.1,
                  heroAttributes: PhotoViewHeroAttributes(tag: index));
            },
            itemCount: missingInfo.commentList[cmtIdx].images.length,
            // loadingBuilder: loadingBuilder,
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            pageController: pageController,
            onPageChanged: galleryPageChange,
            scrollDirection: Axis.horizontal,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                '닫기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}