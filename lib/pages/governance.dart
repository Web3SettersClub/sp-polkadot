import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sp_polkadot/pages/governance/council/councilPage.dart';
import 'package:sp_polkadot/pages/governance/democracy/democracyPage.dart';
import 'package:sp_polkadot/pages/governance/treasury/treasuryPage.dart';
import 'package:sp_polkadot/utils/i18n/index.dart';
import 'package:settpay_sdk/plugin/index.dart';
import 'package:settpay_sdk/utils/i18n.dart';
import 'package:settpay_ui/components/entryPageCard.dart';
import 'package:settpay_ui/pages/dAppWrapperPage.dart';

class Gov extends StatelessWidget {
  Gov(this.plugin);

  final SettPayPlugin plugin;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context).getDic(i18n_full_dic_kusama, 'gov');
    final dicCommon = I18n.of(context).getDic(i18n_full_dic_kusama, 'common');

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    I18n.of(context)
                        .getDic(i18n_full_dic_kusama, 'common')['governance'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: plugin.sdk.api.connectedNode == null
                  ? Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 2),
                      child: Column(
                        children: [
                          CupertinoActivityIndicator(),
                          Text(dicCommon['node.connecting']),
                        ],
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.all(16),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            child: EntryPageCard(
                              dic['democracy'],
                              dic['democracy.brief'],
                              SvgPicture.asset(
                                'packages/sp_polkadot/assets/images/gov/democracy.svg',
                                width: 96,
                                color: Theme.of(context).primaryColor,
                              ),
                              color: Colors.transparent,
                            ),
                            onTap: () => Navigator.of(context)
                                .pushNamed(DemocracyPage.route),
                          ),
                        ),
                        plugin.basic.name == 'polkadot'
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  child: EntryPageCard(
                                    dic['council'],
                                    dic['council.brief'],
                                    SvgPicture.asset(
                                      'packages/sp_polkadot/assets/images/gov/council.svg',
                                      width: 96,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(CouncilPage.route),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            child: EntryPageCard(
                              dic['treasury'],
                              dic['treasury.brief'],
                              SvgPicture.asset(
                                'packages/sp_polkadot/assets/images/gov/treasury.svg',
                                width: 96,
                                color: Theme.of(context).primaryColor,
                              ),
                              color: Colors.transparent,
                            ),
                            onTap: () => Navigator.of(context)
                                .pushNamed(TreasuryPage.route),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            child: EntryPageCard(
                              'Polkassembly',
                              dic['polkassembly'],
                              Image.asset(
                                'packages/sp_polkadot/assets/images/public/polkassembly.png',
                                width: 48,
                              ),
                              color: Colors.transparent,
                            ),
                            onTap: () => Navigator.of(context).pushNamed(
                              DAppWrapperPage.route,
                              arguments:
                                  'https://${plugin.basic.name}.polkassembly.io/',
                              // "https://polkadot.js.org/apps/",
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
