// ignore_for_file: file_names, prefer_final_fields, deprecated_member_use, prefer_const_constructors, prefer_is_empty, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/placeSuggestionData.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

import 'Data/tehsil.dart';

class PlaceSuggestionScreen extends StatefulWidget {
  final PlaceSuggestionData placeSuggestionData;
  const PlaceSuggestionScreen({
    Key key,
    @required this.placeSuggestionData,
  }) : super(key: key);

  @override
  State<PlaceSuggestionScreen> createState() => _PlaceSuggestionScreenState();
}

class _PlaceSuggestionScreenState extends State<PlaceSuggestionScreen> {
  TextEditingController districtTextEditingController;
  TextEditingController tehsilTextEditingController;
  final _formKey = GlobalKey<FormState>();
  FocusNode _blankFocusNode = FocusNode();

  @override
  void initState() {
    districtTextEditingController = TextEditingController();
    tehsilTextEditingController = TextEditingController();
    if (widget.placeSuggestionData.place is Tehsil) {
      districtTextEditingController.text =
          widget.placeSuggestionData.place.parentPlace.name_hi;
    }
    super.initState();
  }

  @override
  void dispose() {
    districtTextEditingController.dispose();
    tehsilTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "जगह बताएं",
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: responsiveFontSize(
                    context,
                    size: ResponsiveFontSizes.s10,
                  ),
                ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).requestFocus(_blankFocusNode);
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.safePercentWidth * 8),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: context.safePercentHeight * 4,
                                    ),
                                    HeadingAndSubheading(
                                      heading: "अपनी जगह बताएं",
                                      subheading:
                                          "यदि आपकी तहसील उपलब्ध नहीं है तो कृपया हमें अपनी तहसील बताएं। आपको जल्द ही आपके क्षेत्र से जोड़ा जायेगा।",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LabelAndCustomTextField(
                                      label: "जिला का नाम",
                                      inputType: TextInputType.name,
                                      textEditingController:
                                          districtTextEditingController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      validator: (String value) {
                                        if (value.length == 0) {
                                          return THIS_FIELD_IS_MANDATORY.tr();
                                        } else
                                          return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: context.safePercentHeight * 5,
                                    ),
                                    LabelAndCustomTextField(
                                      autofocus: true,
                                      label: "तहसील का नाम",
                                      inputType: TextInputType.name,
                                      textEditingController:
                                          tehsilTextEditingController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      validator: (String value) {
                                        if (value.length == 0) {
                                          return THIS_FIELD_IS_MANDATORY.tr();
                                        } else
                                          return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: context.safePercentHeight * 5,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: SUBMIT.tr(),
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        widget.placeSuggestionData.district =
                            districtTextEditingController.text;
                        widget.placeSuggestionData.tehsil =
                            tehsilTextEditingController.text;
                        //show loading

                        await widget.placeSuggestionData.sendSuggestion();
                        //remove loading

                        context.vxNav.push(
                          Uri.parse(
                            MyRoutes.suggestionMessageScreen,
                          ),
                          params: widget.placeSuggestionData,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
