import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:sp_polkadot/sp_polkadot.dart';
import 'package:sp_polkadot/store/staking/types/validatorData.dart';
import 'package:sp_polkadot/utils/i18n/index.dart';
import 'package:settpay_sdk/storage/keyring.dart';
import 'package:settpay_sdk/utils/i18n.dart';
import 'package:settpay_ui/components/accountInfo.dart';
import 'package:settpay_ui/components/addressIcon.dart';
import 'package:settpay_ui/components/borderedTitle.dart';
import 'package:settpay_ui/components/infoItem.dart';
import 'package:settpay_ui/components/roundedCard.dart';
import 'package:settpay_ui/utils/format.dart';
import 'package:settpay_ui/utils/index.dart';

class ValidatorDetailPage extends StatelessWidget {
  ValidatorDetailPage(this.plugin, this.keyring);
  static final String route = '/staking/validator';

  final PluginKusama plugin;
  final Keyring keyring;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          final dicStaking =
              I18n.of(context).getDic(i18n_full_dic_kusama, 'staking');
          final int decimals = plugin.networkState.tokenDecimals[0];
          final ValidatorData detail =
              ModalRoute.of(context).settings.arguments;

          final accInfo =
              plugin.store.accounts.addressIndexMap[detail.accountId];
          final accIcon =
              plugin.store.accounts.addressIconsMap[detail.accountId];

          return Scaffold(
            appBar: AppBar(
              title: Text(dicStaking['validator']),
              centerTitle: true,
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: 2 +
                    (detail.isElected
                        ? detail.nominators.length
                        : plugin.store.staking.nominationsMap[detail.accountId]
                                ?.length ??
                            0),
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return RoundedCard(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          detail.isBlocking
                              ? Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.remove_circle,
                                        color: Theme.of(context).errorColor,
                                        size: 16,
                                      ),
                                      Text(dicStaking['blocking'])
                                    ],
                                  ),
                                )
                              : Container(),
                          AccountInfo(
                            network: plugin.basic.name,
                            accInfo: accInfo,
                            address: detail.accountId,
                            icon: accIcon,
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(top: 16, left: 24),
                            child: Row(
                              children: <Widget>[
                                InfoItem(
                                  title: dicStaking['stake.own'],
                                  content: Fmt.token(detail.bondOwn, decimals),
                                ),
                                InfoItem(
                                  title: dicStaking['stake.other'],
                                  content:
                                      Fmt.token(detail.bondOther, decimals),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 24, bottom: 24),
                            child: Row(
                              children: <Widget>[
                                InfoItem(
                                  title: dicStaking['commission'],
                                  content: NumberFormat('0.00%')
                                      .format(detail.commission / 100),
                                ),
                                InfoItem(
                                  title: dicStaking['reward'],
                                  content:
                                      '${detail.stakedReturnCmp.toStringAsFixed(2)}%',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (i == 1) {
                    final addresses = detail.isElected
                        ? detail.nominators.map((e) => e['who']).toList()
                        : plugin.store.staking.nominationsMap[detail.accountId];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: BorderedTitle(
                            title: dicStaking['nominators'],
                          ),
                        ),
                        FutureBuilder(
                            future: plugin.service.gov
                                .updateIconsAndIndices(addresses),
                            builder: (_, __) => Container()),
                      ],
                    );
                  }
                  if (detail.isElected) {
                    final item = detail.nominators[i - 2];
                    return ListTile(
                      leading: AddressIcon(item['who'],
                          size: 32,
                          svg: plugin
                              .store.accounts.addressIconsMap[item['who']]),
                      title: UI.accountDisplayName(item['who'],
                          plugin.store.accounts.addressIndexMap[item['who']]),
                      trailing: Text(
                          '${Fmt.balance(item['value'].toString(), plugin.networkState.tokenDecimals[0])} ${plugin.networkState.tokenSymbol[0]}'),
                    );
                  } else {
                    final address = plugin
                        .store.staking.nominationsMap[detail.accountId][i - 2];
                    return ListTile(
                      leading: AddressIcon(address,
                          svg: plugin.store.accounts.addressIconsMap[address]),
                      title: UI.accountDisplayName(address,
                          plugin.store.accounts.addressIndexMap[address]),
                    );
                  }
                },
              ),
            ),
          );
        },
      );
}
