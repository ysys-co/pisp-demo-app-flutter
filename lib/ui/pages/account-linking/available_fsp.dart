import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';
import 'package:pispapp/ui/pages/account-linking/account_discovery.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AvailableFSPScreen extends StatelessWidget {
  Widget _buildListItem(String fspName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: ShadowBox(
        color: LightColor.navyBlue1,
        child: ListTile(
          trailing: const Icon(Icons.arrow_forward_ios),
          title: Text(fspName),
          onTap: () => Get.to<dynamic>(AccountDiscovery('fspId', fspName)), // TODO(kkzeng): Pass actual fspId
        ),
      ),
    );
  }

  Widget _buildList() {
    return Obx(() {
      final AvailableFSPController fspController = Get.find<AvailableFSPController>();
      if(fspController.fsps.value.isEmpty) {
        return _buildEmptyDisplay();
      }

      return ListView.builder(
        itemCount: fspController.fsps.value.length + 2,
        itemBuilder: (BuildContext ctxt, int index) {
          switch(index) {
            case 0:  return _buildIcon(); break;
            case 1: return _buildDescText(); break;
            default: return _buildListItem(fspController.fsps.value[index - 2]);
          }
        },
      );
    }
    );
  }

  // For when there are no FSPs available
  Widget _buildEmptyDisplay() {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning, size: 80, color: LightColor.lightNavyBlue),
          TitleText(
            'Oops...no financial providers are supported currently!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDescText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: const Text('Please choose the financial provider of the account that you would like to link:',),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Icon(
        Icons.account_balance,
        color: Colors.blue,
        size: 50,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supported Financial Providers'),
      ),
      body:
      SizedBox.expand(
        child: _buildList(),
      ),
    );
  }
}