// ignore_for_file: avoid_print

import 'package:metadata_fetch/metadata_fetch.dart';

class GetMetaData {
  // Takes an url of a website and returns the url of the image that is used for thumbnail.
  Future<String> getImageUrl(String url) async {
    var metaData = await MetadataFetch.extract(url);
    print(metaData.image); // Testing the fetched data
    if (metaData.image == null) {
      // check if the returned value is "NoImage" or not wherever using this function
      return "NoImage";
    }
    return metaData.image;
  }

  Future<String> getTitleFromLink(String url) async {
    var metaData = await MetadataFetch.extract(url);

    if(metaData.title == null)
    {
      return "";
    }

    return metaData.title;
  }
}
