import 'package:amplify_flutter/amplify_flutter.dart';

class HubService {
  constructor() {
    Amplify.Hub.listen(HubChannel.values,
        (data) => {print("Listening for all messages:  ${data.payload}")});
  }
}
