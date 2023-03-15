// ignore_for_file: file_names, curly_braces_in_flow_control_structures, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import 'Data/selectFirestoreIdentifiers.dart';
import 'searchListWidget.dart';

class ItemSelectionDropDown extends StatefulWidget {
  final FirestoreItemSelection itemSelection;
  const ItemSelectionDropDown({
    Key key,
    this.itemSelection,
  }) : super(key: key);

  @override
  _ItemSelectionDropDownState createState() => _ItemSelectionDropDownState();
}

class _ItemSelectionDropDownState extends State<ItemSelectionDropDown> {
  bool allNecessaryFieldsAreVaild() {
    return validDateIndividualIdentifer(widget.itemSelection);
  }

  bool validDateIndividualIdentifer(FirestoreItemSelection itemSelection) {
    if (itemSelection.preceedingIdentifier != null) {
      itemSelection.preceedingIdentifier.validate();

      if (itemSelection.preceedingIdentifier.isValid)
        return validDateIndividualIdentifer(itemSelection.preceedingIdentifier);
      else
        return false;
    } else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.itemSelection.label,
          style: Theme.of(context).textTheme.headline3.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ).tr(),
        ChangeNotifierProvider<FirestoreItemSelection>.value(
          value: widget.itemSelection,
          builder: (context, child) {
            return Consumer<FirestoreItemSelection>(
              builder: (context, itemSelection, child) {
                if (itemSelection.gettingItems)
                  return SpinKitThreeBounce(
                    color: maroonColor,
                    size: 24,
                  );
                else
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        onTap: () {
                          if (allNecessaryFieldsAreVaild())
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return SearchListWidget(
                                  items: widget.itemSelection.items,
                                  itemSelection: itemSelection,
                                );
                              },
                            ));
                        },
                        child: ListTile(
                          title: Text(
                            itemSelection.selectedItem == null ||
                                    itemSelection.selectedItem.id ==
                                        NO_ITEM_SELECTED
                                ? SELECT.tr()
                                : itemSelection.selectedItem.name_hi ??
                                    itemSelection.selectedItem.name_en,
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      //
                      ValueListenableBuilder<String>(
                        valueListenable: widget.itemSelection.errorMessage,
                        builder: (context, value, child) {
                          return widget.itemSelection.errorMessage.value == null
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    widget.itemSelection.errorMessage.value,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: responsiveFontSize(context,
                                            size: ResponsiveFontSizes.s)),
                                  ),
                                );
                        },
                      )
                    ],
                  );
              },
            );
          },
        ),
      ],
    );
  }
}
                      // SearchChoices.single(
                      //   items: widget.itemSelection.items
                      //       .map<DropdownMenuItem<Identifier>>(
                      //         (e) => getDropDownItem(e),
                      //       )
                      //       .toList(),
                      //   value: itemSelection.selectedItem,
                      //   style: TextStyle(color: Colors.black),
                      //   hint: SELECT.tr(),
                      //   onTap: () {
                      //     print("open");
                      //   },
                      //   searchHint: null,
                      //   searchFn: (String keyword,
                      //       List<DropdownMenuItem<Identifier>> items) {
                      //     List<int> ret = [];
                      //     if (items != null && keyword.isNotEmpty) {
                      //       keyword.split(" ").forEach((k) {
                      //         int i = 0;
                      //         items.forEach((item) {
                      //           if (k.isNotEmpty &&
                      //               (item.value.name
                      //                   .toString()
                      //                   .toLowerCase()
                      //                   .contains(k.toLowerCase()))) {
                      //             ret.add(i);
                      //           }
                      //           i++;
                      //         });
                      //       });
                      //     }
                      //     if (keyword.isEmpty) {
                      //       ret = Iterable<int>.generate(items.length).toList();
                      //     }
                      //     return (ret);
                      //   },
                      //   // searchFn: ,
                      //   onChanged: itemSelection.onChanged,
                      //   dialogBox: true,
                      //   isExpanded: true,
                      //   closeButton: null,
                      //   // label: itemSelection.label,
                      // ),
