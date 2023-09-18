import 'package:amplify_flutter/amplify_flutter.dart';

class HubService {
  HubService() {
    Amplify.Hub.listen(
        HubChannel.values
            as HubChannel<dynamic, HubEvent>, // Adjusted this line
        (HubEvent<dynamic> data) {
      // Adjusted this line
      print("Listening for all messages: ${data.payload}");
    });
  }
}
