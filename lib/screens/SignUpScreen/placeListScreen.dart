// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/placeIdentifierTile.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Data/place.dart';
import 'package:easy_localization/easy_localization.dart';

class PlaceList extends StatefulWidget {
  final Place place;
  const PlaceList({
    Key key,
    @required this.place,
  }) : super(key: key);

  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  TextEditingController textEditingController;

  @override
  void initState() {
    widget.place.initialisePlaceList();
    textEditingController = TextEditingController();
    textEditingController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(listener);
    textEditingController.dispose();
    super.dispose();
  }

  void listener() {
    widget.place.searchBarTextFieldListener(textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget?.place?.label.toString(),
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: responsiveFontSize(
                    context,
                    size: ResponsiveFontSizes.s10,
                  ),
                ),
          ).tr(),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ChangeNotifierProvider<Place>.value(
          value: widget.place,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  constraints: BoxConstraints.expand(),
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(widget.place.image),
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.safePercentWidth * 10),
                      child: Card(
                        elevation: 2.0,
                        child: Container(
                            color: Theme.of(context).colorScheme.background,
                            child: TextField(
                              autofocus: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  FontAwesomeIcons.search,
                                  size: 20,
                                ),
                                // prefix: Icon(FontAwesomeIcons.search),
                                errorStyle: TextStyle(color: Colors.red),
                                focusColor: maroonColor,
                                enabledBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                focusedBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                errorBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                disabledBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                focusedErrorBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                hintText: "खोजें",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                    ),
                              ),
                              // maxLines: multiLines,
                              keyboardType: TextInputType.name,
                              controller: textEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            )),
                      ),
                    ),
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    Flexible(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.safePercentWidth * 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1.0),
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(width: 1.0, color: Colors.grey[200]),
                          ),
                          child: Consumer<Place>(
                            builder: (context, value, child) {
                              if (value.loading)
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        maroonColor),
                                    // strokeWidth: 3,
                                  ),
                                );
                              else if (value.matchedKeywordsList.length > 0)
                                return CupertinoScrollbar(
                                  isAlwaysShown: true,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        value.matchedKeywordsList.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          value.matchedKeywordsList.length) {
                                        return BottomButton(
                                            place: widget.place);
                                      } else {
                                        Places places =
                                            value.matchedKeywordsList[index];
                                        return InkWell(
                                          onTap: () async {
                                            await widget.place
                                                .onItemTap(context, places);
                                          },
                                          child: PlaceIdentifierTile(
                                            places: places,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              else
                                return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}

OutlineInputBorder textFormFieldBorder(BuildContext context, {Color color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.25, color: color),
    borderRadius: BorderRadius.circular(4),
  );
}

class BottomButton extends StatelessWidget {
  final Place place;
  const BottomButton({Key key, @required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (place.showBottomButton)
        ? InkWell(
            onTap: () async {
              await place.onTapBottomButton(context);
            },
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Text(
                  place.bottomButtonText.toString(),
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(
                          context,
                          size: ResponsiveFontSizes.s,
                        ),
                        color: maroonColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          )
        : Container();
  }
}
