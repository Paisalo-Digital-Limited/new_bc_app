import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../network/api_service.dart';
import 'currentLocation.dart';

class SaveGeoTags{
  var _latitude=0.0;
  var _longitude=0.0;



  Future<void> getTansactionDetailsByCode(BuildContext context,String activityName,String csoId) async {
    currentLocation _locationService = currentLocation();
    try {
      Map<String, dynamic> locationData =
          await _locationService.getCurrentLocation();

      _latitude = locationData['latitude'];
      _longitude = locationData['longitude'];

    } catch (e) {
      print("Error getting current location: $e");

    }

    final api = Provider.of<ApiService>(context, listen: false);
    return api.getBcUserInsertTracking(csoId, activityName, _latitude.toString(), _longitude.toString()).then((value) => {

    }
    );

  }


}