// ignore_for_file: library_prefixes, file_names

import 'dart:math' as Math;

class LocationDistanceCalculator {
  double getDistance({double lat1, double lat2, double lon1, double lon2}) {
    lon1 = toRadians(lon1);
    lon2 = toRadians(lon2);
    lat1 = toRadians(lat1);
    lat2 = toRadians(lat2);

    // Haversine formula
    double dlon = lon2 - lon1;
    double dlat = lat2 - lat1;
    double a = Math.pow(Math.sin(dlat / 2), 2) +
        Math.cos(lat1) * Math.cos(lat2) * Math.pow(Math.sin(dlon / 2), 2);

    double c = 2 * Math.asin(Math.sqrt(a));

    // Radius of earth in kilometers. Use 3956
    // for miles
    double r = 6371;

    double distance = (c * r);
    distance *= 10;
    distance = distance.floorToDouble();
    distance /= 10;

    // calculate the result
    return distance;
  }

  double toRadians(double deg) {
    double rad = (deg * Math.pi) / 180.0;
    return rad;
  }
}
