import 'package:fusion/models/notification.dart';

class DashboardData {
  List<Notification>? notifications;
  List? designation;
  List? clubDetails;
 late String designatio="hello";
  void set(String d)
  {
    designatio = d;
    print(designatio);
  }
  
  DashboardData({this.clubDetails, this.designation, this.notifications});

  factory DashboardData.fromJson(Map json) {
    return DashboardData(
      clubDetails: json["club_details"],
      designation: json["desgination_info"],
      notifications: Notification.fromListJson(json["notifications"]),
    );
  }

  void printDetails() {
    print('Dashboard Data:');
    print('Notifications: $notifications');
    print('Designation: $designatio');
    print('Club Details: $clubDetails');

  }
}
