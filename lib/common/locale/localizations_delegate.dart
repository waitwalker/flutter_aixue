import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/locale/localizations.dart';


class MTTLocalizationsDelegate extends LocalizationsDelegate<MTTLocalization> {

  MTTLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<MTTLocalization> load(Locale locale) {
    return SynchronousFuture<MTTLocalization>(MTTLocalization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MTTLocalization> old) {
    return false;
  }

  ///全局静态的代理
  static MTTLocalizationsDelegate delegate = MTTLocalizationsDelegate();
}
