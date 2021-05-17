import 'package:flutter/cupertino.dart';
import 'package:sp_polkadot/sp_polkadot.dart';
import 'package:sp_polkadot/service/gov.dart';
import 'package:sp_polkadot/service/staking.dart';
import 'package:settpay_sdk/storage/keyring.dart';
import 'package:settpay_sdk/storage/types/keyPairData.dart';
import 'package:settpay_sdk/utils/i18n.dart';
import 'package:settpay_ui/components/passwordInputDialog.dart';
import 'package:settpay_ui/utils/i18n.dart';

class PluginApi {
  PluginApi(PluginKusama plugin, Keyring keyring)
      : staking = ApiStaking(plugin, keyring),
        gov = ApiGov(plugin, keyring),
        plugin = plugin;
  final ApiStaking staking;
  final ApiGov gov;

  final PluginKusama plugin;

  Future<String> getPassword(BuildContext context, KeyPairData acc) async {
    final password = await showCupertinoDialog(
      context: context,
      builder: (_) {
        return PasswordInputDialog(
          plugin.sdk.api,
          title: Text(
              I18n.of(context).getDic(i18n_full_dic_ui, 'common')['unlock']),
          account: acc,
        );
      },
    );
    return password;
  }
}
