import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/model/noti_setting.dart';
import 'package:iris_flutter/repository/member_repository.dart';
import 'package:iris_flutter/utils/region_name_utils.dart';
import 'package:iris_flutter/view/comm/custom_snackbar.dart';
import 'package:iris_flutter/view/page/my_page/my_page.dart';

class NotificationSettingController {
  RxString selectedRegion1D = ''.obs;
  RxString selectedRegion2D = ''.obs;
  RxBool isSwitched = false.obs;

  Future<void> saveSetting() async {
    if (isSwitched.value) {
      // 알림 on
      final fcmToken = await FirebaseMessaging.instance.getToken();
      log('fcmToken: ${fcmToken}');
      patchSetting(region: concatRegionNames(selectedRegion1D.value, selectedRegion2D.value), deviceToken: fcmToken!);
    } else {
      // 알림 off
      patchSetting(region: null, deviceToken: null);
    }
  }

  Future<void> patchSetting(
      {String? region, String? deviceToken}) async { // 관심 지역 설정, 수정 -> region required
    final dio = createDio();
    MemberRepository memberRepository = MemberRepository(dio);

    try {
      await memberRepository
          .patchPush(NotiSetting(region: region, deviceToken: deviceToken));
      // 설정 완료, 안내
      customSnackBar(title: '알림 설정 저장', message: '설정 저장이 완료되었습니다.');
      Get.to(()=>const MyPage());
    } on DioException catch (e) {
      log('[DioException] ${e.response}');
      customErrorSnackBar(title: '알림 설정 실패', message: '설정 저장이 실패하였습니다. 다시 시도해 주세요.');
    }
  }

  Future<void> getSetting() async {
    final dio = createDio();
    MemberRepository memberRepository = MemberRepository(dio);

    try {
      final resp = await memberRepository.getPushRegion();
      log('getSetting: ${resp}');

      if (resp.isNotEmpty) {
        isSwitched.value = true;
        selectedRegion1D.value = splitRegionNames(resp)[0];
        selectedRegion2D.value = splitRegionNames(resp)[1];

        log('selectedRegion1D: ${selectedRegion1D.value}');
        log('selectedRegion2D: ${selectedRegion2D.value}');
      }
    } on DioException catch (e) {
      log('[DioException] ${e.message}');
    }
  }
}
