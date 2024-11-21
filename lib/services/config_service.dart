import 'dart:convert';

import 'package:flagsmith/flagsmith.dart';
import 'package:tt_18/models/config.dart';

class ConfigService {
  static const _apikey = 'RyRVYZcXELbojc8qigQX6n';

  late final FlagsmithClient _flagsmithClient;

  late final ConfigModel _config;

  Future<ConfigService> init() async {
    _flagsmithClient = await FlagsmithClient.init(
      apiKey: _apikey,
      config: const FlagsmithConfig(
        caches: true,
      ),
    );
    await _flagsmithClient.getFeatureFlags(reload: true);

    final json = jsonDecode(
        await _flagsmithClient.getFeatureFlagValue(ConfigKey.config.name) ??
            '') as Map<String, dynamic>;
    _config = ConfigModel.fromJson(json);
    return this;
  }

  void closeClient() => _flagsmithClient.close();

  ConfigModel get config => _config;
}
