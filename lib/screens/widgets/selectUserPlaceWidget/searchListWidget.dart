// ignore_for_file: file_names, avoid_print, avoid_function_literals_in_foreach_calls, deprecated_member_use, prefer_is_empty, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/utils/StringCaseChange.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Data/selectFirestoreIdentifiers.dart';

class SearchListWidget extends StatefulWidget {
  final FirestoreItemSelection itemSelection;
  final List<Places> items;

  const SearchListWidget({
    Key key,
    @required this.items,
    @required this.itemSelection,
  }) : super(key: key);

  @override
  _SearchListWidgetState createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  TextEditingController textEditingController;
  List<int> filteredItemsIndices = <int>[];

  @override
  void initState() {
    filteredItemsIndices = Iterable<int>.generate(widget.items.length).toList();
    textEditingController = TextEditingController();
    textEditingController.addListener(searchItems);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(searchItems);
    textEditingController.dispose();
    super.dispose();
  }

  void searchItems() {
    filteredItemsIndices = searchFunction();
    print(filteredItemsIndices.length);
    setState(() {});
  }

  List<int> searchFunction() {
    String keyword = textEditingController.text;
    List<int> ret = [];
    if (widget.items != null && keyword.isNotEmpty) {
      keyword.split(" ").forEach((k) {
        int i = 0;
        widget.items.forEach((item) {
          if (k.isNotEmpty &&
              (item.name_en
                  .toString()
                  .toLowerCase()
                  .contains(k.toLowerCase()))) {
            ret.add(i);
          }
          i++;
        });
      });
    }
    if (keyword.isEmpty) {
      ret = Iterable<int>.generate(widget.items.length).toList();
    }
    return (ret);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: widget.itemSelection.label,
      ),
      body: SafeArea(
        child: Padding(
          padding: getPostWidgetSymmetricPadding(context),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: textEditingController,
                style: Theme.of(context).textTheme.headline2.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s10),
                    fontWeight: FontWeight.normal),
              ),
              Expanded(
                child: (filteredItemsIndices.length > 0)
                    ? ListView.builder(
                        itemCount: filteredItemsIndices.length,
                        itemBuilder: (context, index) {
                          Places val =
                              widget.items[filteredItemsIndices[index]];
                          if (val.name_hi != null || val.name_en != null)
                            return getDropDownItem(val);
                          else
                            return Container();
                        },
                      )
                    : Center(
                        child: Text(
                          'कोई ${widget.itemSelection.label} उपलब्ध नहीं है',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: responsiveFontSize(context,
                                    size: ResponsiveFontSizes.s),
                              ),
                        ).tr(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDropDownItem(
    Places val,
  ) {
    return InkWell(
      onTap: () {
        widget.itemSelection.onChanged(val);
        Navigator.pop(context);
      },
      enableFeedback: false,
      splashColor: Colors.transparent,
      child: DropdownMenuItem<Places>(
        child: Text(
          StringCaseChange.onlyFirstLetterCapital(val.name_hi ?? val.name_en)
              .toString(),
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s10),
              fontWeight: FontWeight.normal),
        ),
        value: val,
      ),
    );
  }
}
