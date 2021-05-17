import 'package:sp_polkadot/store/accounts.dart';
import 'package:sp_polkadot/store/cache/storeCache.dart';
import 'package:sp_polkadot/store/gov/governance.dart';
import 'package:sp_polkadot/store/staking/staking.dart';

class PluginStore {
  PluginStore(StoreCache cache)
      : staking = StakingStore(cache),
        gov = GovernanceStore(cache);
  final StakingStore staking;
  final GovernanceStore gov;
  final AccountsStore accounts = AccountsStore();
}
