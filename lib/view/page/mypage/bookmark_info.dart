import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/model/missing_info.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';

class BookmarkInfo extends StatefulWidget {
  const BookmarkInfo({super.key});

  @override
  State<BookmarkInfo> createState() => _BookmarkInfoState();
}

class _BookmarkInfoState extends State<BookmarkInfo> {
  @override
  void initState() {
    Get.put(MainController()).setTmpData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    final mainController = Get.find<MainController>();

    return Scaffold(
        appBar: customAppBar(title: "북마크한 실종 정보"),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: mainController.missingInfoList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    itemCount: mainController.missingInfoList.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return singleInfo(mainController.missingInfoList[idx]);
                    })
                : const Center(
                    child: Text("북마크한 실종 정보가 없습니다."),
                  )));
  }

  singleInfo(MissingInfo missingInfo) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/exImage.png',
                height: 170,
                width: 380,
                fit: BoxFit.fitWidth,
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${missingInfo.name} / ${missingInfo.age}세 / ${missingInfo.address}",
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark))
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: Theme.of(context).hintColor,
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Text(
                '24분전',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}