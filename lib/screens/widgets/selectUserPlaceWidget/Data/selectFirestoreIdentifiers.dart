// ignore_for_file: file_names, curly_braces_in_flow_control_structures, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';

abstract class FirestoreItemSelection extends ChangeNotifier {
  String label;
  Places selectedItem;
  // String selectedItem;
  List<Places> items;
  bool allowOnChangeCall = true;
  bool gettingItems = false;
  IdentifierType identifierType;
  ValueNotifier<String> errorMessage;

  FirestoreItemSelection preceedingIdentifier;

  FirestoreItemSelection({this.identifierType, this.preceedingIdentifier}) {
    initialise();

    if (preceedingIdentifier != null) {
      preceedingIdentifier.addListener(initialise);
    }
  }

  @override
  void dispose() {
    preceedingIdentifier.removeListener(initialise);
    super.dispose();
  }

  initialise() {
    errorMessage = ValueNotifier(null);
    selectedItem =
        Places(id: NO_ITEM_SELECTED, parentId: NO_ITEM_SELECTED, type: null);
    getItems();
  }

  validate() {
    if (selectedItem.id == null ||
        selectedItem.id == NO_ITEM_SELECTED ||
        selectedItem.id == "")
      errorMessage.value = "कृपया $label चुनें";
    else
      errorMessage.value = null;
    // notifyListeners();
  }

  bool get isValid => errorMessage.value == null;

  Future<List<Places>> getIdentifiersFromFirestore();

  Future<List<Places>> fetchItems() async {
    List<Places> list = await getIdentifiersFromFirestore();
    return list;
  }

  getItems() async {
    gettingItems = true;
    notifyListeners();
    items = await fetchItems();
    gettingItems = false;
    notifyListeners();
  }

  onChanged(Places value) {
    if (!allowOnChangeCall) {
      allowOnChangeCall = true;
      return;
    }
    onItemTap(value);
  }

  onItemTap(Places val) {
    selectedItem = val;
    print(selectedItem);
    validate();
    notifyListeners();
  }

  // onNewItemTap(String val) {
  //   print("new item tap");
  //   selectedItem = Places(name: val);
  //   items.add(Places(name: val));
  //   print(selectedItem);
  //   allowOnChangeCall = false;
  //   notifyListeners();
  // }
}
