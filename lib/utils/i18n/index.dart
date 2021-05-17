import 'package:sp_polkadot/utils/i18n/en/common.dart';
import 'package:sp_polkadot/utils/i18n/en/gov.dart';
import 'package:sp_polkadot/utils/i18n/en/staking.dart';
import 'package:sp_polkadot/utils/i18n/zh/common.dart';
import 'package:sp_polkadot/utils/i18n/zh/gov.dart';
import 'package:sp_polkadot/utils/i18n/zh/staking.dart';

const Map<String, Map<String, Map<String, String>>> i18n_full_dic_kusama = {
  'en': {
    'common': enCommon,
    'staking': enStaking,
    'gov': enGov,
  },
  'zh': {
    'common': zhCommon,
    'staking': zhStaking,
    'gov': zhGov,
  }
};
