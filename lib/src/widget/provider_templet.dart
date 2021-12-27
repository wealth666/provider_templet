import 'package:flutter/cupertino.dart';
import 'package:provider_templet/src/widget/config_processor.dart';

class ProviderTemplet {
  ProviderTemplet._internal();

  static final ProviderTemplet instance = ProviderTemplet._internal();

  static late ConfigProcessor? _config;

  static ConfigProcessor get config => _config ?? BaseConfigProcessor();

  static setUp(ConfigProcessor? config) {
    if (config != null) {
      _config = config;
    }
  }
}
