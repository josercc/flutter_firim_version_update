library flutter_firim_version_update;

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_update_dialog/flutter_update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

class FirimVersionUpdate extends StatefulWidget {
  final String apiToken;
  final Widget child;
  const FirimVersionUpdate({
    Key? key,
    required this.apiToken,
    required this.child,
  }) : super(key: key);

  @override
  _FirimVersionUpdateState createState() => _FirimVersionUpdateState();
}

class _FirimVersionUpdateState extends State<FirimVersionUpdate> {
  @override
  void initState() {
    super.initState();
    showUpdate();
  }

  Future<void> showUpdate() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    String appVersion = info.version;
    String appBuildNumber = info.buildNumber;
    String packageName = info.packageName;
    Map<String, dynamic> queryParameters = {};
    queryParameters["api_token"] = widget.apiToken;
    if (Platform.isIOS) {
      queryParameters["type"] = "ios";
    } else if (Platform.isAndroid) {
      queryParameters["type"] = "android";
    } else {
      throw "Current paltform not support";
    }
    Response<Map<String, dynamic>> response =
        await Dio().get<Map<String, dynamic>>(
      "http://api.bq04.com/apps/latest/$packageName",
      queryParameters: queryParameters,
    );
    Map<String, dynamic>? data = response.data;
    if (data == null) return;
    String? version = data["versionShort"] as String?;
    String? changeLog = data["changelog"] as String?;
    String? build = data["build"] as String?;
    String? installUrl = data["update_url"] as String?;
    if (version == null || installUrl == null) return;
    if (Version.parse(version) < Version.parse(appVersion)) return;
    if (Version.parse(build) <= Version.parse(appBuildNumber)) return;
    UpdateDialog.showUpdate(
      context,
      title:
          "有最新测试版本:$appVersion${build != null ? "($appBuildNumber)" : ""}发布，是否需要升级？",
      updateContent: "更新内容:\n${changeLog ?? "无"}",
      onUpdate: () {
        launch(installUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
