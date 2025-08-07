import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';
import 'tabs/call_center_tab.dart';
import 'tabs/hubungi_kami_tab.dart';
import 'tabs/kantor_ipska_tab.dart';

class KontakKamiPage extends StatelessWidget {
  const KontakKamiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Kontak Kami'),
        backgroundColor: AppTheme.backgroundColor,
        body: Column(
          children: [
            Material(
              color: AppTheme.whiteColor,
              child: TabBar(
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: Colors.black54,
                indicatorColor: AppTheme.primaryColor,
                indicatorWeight: 3,
                labelStyle: AppTheme.textBold14,
                tabs: const [
                  Tab(text: 'Hubungi Kami'),
                  Tab(text: 'Call Center'),
                  Tab(text: 'Kantor IPSKA'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [HubungiKamiTab(), CallCenterTab(), KantorIpskaTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
