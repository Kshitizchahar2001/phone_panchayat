// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/main_screen/HomeTabChildren/panchayatSamitiList.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserAreaIdentifiersData.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserPlace.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class SarpanchTab extends StatefulWidget {
  final TabController tabController;
  const SarpanchTab({Key key, @required this.tabController}) : super(key: key);

  @override
  State<SarpanchTab> createState() => _SarpanchTabState();
}

class _SarpanchTabState extends State<SarpanchTab>
    with AutomaticKeepAliveClientMixin {
  SelectUserAreaIdentifiersData selectUserAreaIdentifiers;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    selectUserAreaIdentifiers = SelectUserAreaIdentifiersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (Services.globalDataNotifier.localUser.district_id != null) {
      return PanchayatSamitiList(
        tabController: widget.tabController,
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                padding: getPostWidgetSymmetricPadding(
                  context,
                  vertical: 0,
                ),
                child: SelectUserPlace(
                  selectUserAreaIdentifiersData: selectUserAreaIdentifiers,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: SUBMIT,
              autoSize: true,
              onPressed: () async {
                selectUserAreaIdentifiers.district.validate();
                selectUserAreaIdentifiers.selectedUserType.validate();
                if (selectUserAreaIdentifiers.district.isValid &&
                    selectUserAreaIdentifiers.selectedUserType.allValid()) {
                  showMaterialDialog(context);
                  await selectUserAreaIdentifiers.onSubmit();
                  Navigator.pop(context);
                  setState(() {});
                }
              },
            ),
          ),
        ],
      );
    }
  }
}
