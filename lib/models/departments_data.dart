import 'package:google_maps_flutter/google_maps_flutter.dart';

class Department {
  final String name;
  final LatLng location;
  final List<String> aliases;

  Department({
    required this.name,
    required this.location,
    this.aliases = const [],
  });
}

final List<Department> muetDepartments = [
  Department(
    name: "Software Engineering",
    location: LatLng(25.404609, 68.261447),
    aliases: ["SE", "Software Engineering"],
  ),
  Department(
    name: "Civil Engineering",
    location: LatLng(25.399639, 68.256312),
    aliases: ["CE", "Civil Engineering"],
  ),
  Department(
    name: "Computer Science",
    location: LatLng(25.40752048959361, 68.26270022458745),
    aliases: ["CS", "Computer Science", "BSCS"],
  ),
  Department(
    name: "Computer Systems Engineering",
    location: LatLng(25.40683794830437, 68.26257504542033),
    aliases: ["CSE", "Computer Science"],
  ),
  Department(
    name: "Electrical Engineering",
    location: LatLng(25.41433034474426, 68.26024404593511),
    aliases: ["EL", "Electrical Engineering"],
  ),
  Department(
    name: "Mechanical Engineering",
    location: LatLng(25.4147088269939, 68.25991805101545),
    aliases: ["ME", "Mechanical Engineering"],
  ),
  Department(
    name: "Telecommunication Engineering",
    location: LatLng(25.407314947896957, 68.26326692020157),
    aliases: ["TL", "Telecommunication Engineering"],
  ),
  Department(
    name: "Industrial Engineering",
    location: LatLng(25.39950993493938, 68.2592288832396),
    aliases: ["IE", "Industrial Engineering"],
  ),
  Department(
    name: "Admin Block",
    location: LatLng(25.401635771988712, 68.25876518675965),
    aliases: ["Admin Block", "Administration"],
  ),
  Department(
    name: "Library",
    location: LatLng(25.40792920800978, 68.26170992566534),
    aliases: ["Library", "Central Library", "CL"],
  ),
  Department(
    name: "Auditorium",
    location: LatLng(25.40901010314514, 68.26137096227846),
    aliases: ["Auditorium", "MUET Auditorium"],
  ),
  Department(
    name: "Student Center",
    location: LatLng(25.410522958913393, 68.25820328965054),
    aliases: ["Student Center", "STC"],
  ),
  Department(
    name: "Hostel A",
    location: LatLng(25.41021138136977, 68.25761360710005),
    aliases: ["Hostel A", "Hostel"],
  ),
  Department(
    name: "Hostel B",
    location: LatLng(25.407362600308808, 68.2562241826706),
    aliases: ["Hostel B", "Hostel"],
  ),
  Department(
    name: "Cafeteria",
    location: LatLng(25.414681195060602, 68.25905013958642),
    aliases: ["CC", "Cafeteria", "Canteen"],
  ),
  Department(
    name: "Sports GYM",
    location: LatLng(25.412222357969934, 68.25713946828492),
    aliases: ["Sports GYM", "Gymnasium"],
  ),
  Department(
    name: "Metallurgy & Materials Engineering",
    location: LatLng(25.40571712632762, 68.25995043091652),
    aliases: ["MME", "Metallurgy & Materials Engineering"],
  ),
  Department(
    name: "Mining Engineering",
    location: LatLng(25.40594904918197, 68.25937056116932),
    aliases: ["MN", "Mining Engineering"],
  ),
  Department(
    name: "Petroleum & Natural Gas Engineering",
    location: LatLng(25.407161111343427, 68.26076600790041),
    aliases: ["PG", "Petroleum & Natural Gas Engineering"],
  ),
  Department(
    name: "Environmental Engineering",
    location: LatLng(25.40192993052332, 68.25676354698973),
    aliases: ["EN", "Environmental Engineering"],
  ),
  Department(
    name: "Biomedical Engineering",
    location: LatLng(25.40458406252144, 68.26019039922998),
    aliases: ["BM", "Biomedical Engineering"],
  ),
  Department(
    name: "City & Regional Planning",
    location: LatLng(25.40081023442229, 68.2562333338461),
    aliases: ["CRP", "City & Regional Planning"],
  ),
  Department(
    name: "Architecture",
    location: LatLng(25.41063661217873, 68.25965382952332),
    aliases: ["AR", "Architecture"],
  ),
  Department(
    name: "Basic Sciences & Related Studies",
    location: LatLng(25.414777674462986, 68.2587582778012),
    aliases: ["BSRS", "Basic Sciences & Related Studies"],
  ),
  Department(
    name: "Center for English Language & Linguistics (CELL)",
    location: LatLng(25.40781701951725, 68.26026272808458),
    aliases: ["CELL", "Center for English Language & Linguistics"],
  ),
  Department(
    name: "Innovation & Entrepreneurship Center (IEC)",
    location: LatLng(25.399565992620563, 68.26499942700093),
    aliases: ["IEC", "Innovation & Entrepreneurship Center"],
  ),
  Department(
    name: "Office of Research, Innovation & Commercialization (ORIC)",
    location: LatLng(25.4087040283643, 68.26307946016703),
    aliases: ["ORIC", "Office of Research, Innovation & Commercialization"],
  ),
  Department(
    name: "Quality Enhancement Cell (QEC)",
    location: LatLng(25.39864069629468, 68.26412757416098),
    aliases: ["QEC", "Quality Enhancement Cell"],
  ),
  Department(
    name: "Planning & Development Directorate",
    location: LatLng(25.413103569839883, 68.26116470470653),
    aliases: ["Planning & Development Directorate", "PDD"],
  ),
  Department(
    name: "Men’s Hostels Block",
    location: LatLng(25.407407168937244, 68.25635033317248),
    aliases: ["Men’s Hostels Block", "Hostel"],
  ),
  Department(
    name: "Women’s Hostel Block",
    location: LatLng(25.40414789247281, 68.26462637601273),
    aliases: ["Women’s Hostel Block", "Hostel"],
  ),
  Department(
    name: "Points Bus Stop",
    location: LatLng(25.41569987664729, 68.25824123410379),
    aliases: ["Points Bus Stop", "Bus Stop"],
  ),
  Department(
    name: "MUET Mosque",
    location: LatLng(25.406330227206855, 68.26476409000762),
    aliases: ["MUET Mosque", "Mosque"],
  ),
  Department(
    name: "BBA Department",
    location: LatLng(25.39864465627146, 68.26405248704225),
    aliases: ["BBA Department", "BBA"],
  ),

  // Add remaining departments/blocks similarly...
];
