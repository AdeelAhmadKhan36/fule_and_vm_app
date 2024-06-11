import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/views/Location_Screen.dart';
import 'package:fule_and_vm_app/views/vehicle_maintenance/maintenance_homepage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:fule_and_vm_app/widgets/appbar.dart';
import 'package:fule_and_vm_app/widgets/mapwithSearchbar.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:fule_and_vm_app/views/fule_dilevery/Order_Conformation_Scree.dart';
import 'views/vehicle_maintenance/vehicle_main.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({Key? key, required String selectedLocationName}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool isSelectedPetrol = false;
  bool isSelectedDiesel = false;
  bool isSelectedEngineOil = false;
  int? selectedQuantity;
  DateTime? selectedDate;
  String? selectedTimeSlot1;
  String? selectedTimeSlot2;
  String? _selectedLocationName;
  String? selectedFuelType;
  Position? _selectedLocation;
  String locationText = "Mansehra KPK Pakistan"; // Default location text

  String ?userName; // Add a variable to hold the user's name

  final List<int> quantities = List.generate(10, (index) => index + 1);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool get isOrderButtonEnabled {
    return selectedFuelType != null &&
        selectedQuantity != null &&
        selectedDate != null &&
        (selectedTimeSlot1 != null || selectedTimeSlot2 != null) &&
        (isSelectedPetrol || isSelectedDiesel || isSelectedEngineOil);
  }

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null) {
      _selectedLocation = args['position'];
      _selectedLocationName = args['name'];
      if (_selectedLocationName != null) {
        locationText = _selectedLocationName!;
      }
    }
    _fetchUserName(); // Fetch the user's name
  }

  Future<void> _fetchUserName() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');
        DocumentReference userDocRef = usersCollection.doc(user.uid);
        DocumentSnapshot userDoc = await userDocRef.get();

        if (userDoc.exists) {
          String name = userDoc['name'];
          setState(() {
            userName = name;
          });
        }
      }
    } catch (e) {
      print('Error fetching User Name: $e');
    }
  }



  void updateLocationText(String? selectedLocationName) {
    setState(() {
      locationText = selectedLocationName ?? "Default Location";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        leftIcon: Icons.menu,
        rightIcon: Icons.notifications,
        onLeftIconPressed: () {
          print('Left icon pressed');
        },
        onRightIconPressed: () {
          print('Right icon pressed');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(
                text: 'Welcome $userName', // Display the user's name
                color: Color(blackcolr.value),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Color(Maincolor.value),
                  ),
                  const SizedBox(width: 4),
                  ReusableText(
                    text: locationText,
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_location),
                    onPressed: () async {
                      final result = await Get.to(LocationScreen());
                      if (result != null) {
                        setState(() {
                          _selectedLocation = result['position'];
                          _selectedLocationName = result['name'];
                          updateLocationText(_selectedLocationName);
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MapWithSearchBar(),
              const SizedBox(height: 20),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose the Option',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          OptionIcon(
                            icon: Icons.electric_car,
                            title: "Maintenance",
                            color: Color(Maincolor.value),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>vehiclemaintenance_home()),
                              );
                            },
                          ),
                          OptionIcon(
                            icon: Icons.local_gas_station_outlined,
                            title: "Petrol",
                            color: isSelectedPetrol ? Color(kPrimaryColor.value): Color(Whitecolr.value),
                            onPressed: () {
                              setState(() {
                                isSelectedPetrol = !isSelectedPetrol;
                                if (isSelectedPetrol) {
                                  isSelectedDiesel = false;
                                  isSelectedEngineOil = false;
                                  selectedFuelType = "Petrol";
                                }
                              });
                            },
                          ),
                          OptionIcon(
                            icon: Icons.bike_scooter,
                            title: "Diesel",
                            color: isSelectedDiesel ? Color(kPrimaryColor.value) : Color(Whitecolr.value),
                            onPressed: () {
                              setState(() {
                                isSelectedDiesel = !isSelectedDiesel;
                                if (isSelectedDiesel) {
                                  isSelectedPetrol = false;
                                  isSelectedEngineOil = false;
                                  selectedFuelType = "Diesel";
                                }
                              });
                            },
                          ),
                          OptionIcon(
                            icon: Icons.directions_walk,
                            title: "Engine Oil",
                            color: isSelectedEngineOil ? Color(kPrimaryColor.value) : Color(Whitecolr.value),
                            onPressed: () {
                              setState(() {
                                isSelectedEngineOil = !isSelectedEngineOil;
                                if (isSelectedEngineOil) {
                                  isSelectedPetrol = false;
                                  isSelectedDiesel = false;
                                  selectedFuelType = "Engine Oil";
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(kGrey.value)),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose your requirement for fuel',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 160,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color(Maincolor.value),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                        3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Select Quantity (Lts)',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: quantities.length,
                                            itemBuilder: (context, index) {
                                              final quantity =
                                              quantities[index];
                                              return ListTile(
                                                title: Text('$quantity Liters'),
                                                onTap: () {
                                                  setState(() {
                                                    selectedQuantity = quantity;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                selectedQuantity != null
                                    ? '${selectedQuantity!} Liters'
                                    : "Quantity (Lts)",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 160,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color(Whitecolr.value),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Center(
                              child: Text(
                                selectedDate != null
                                    ? selectedDate!.toString().substring(0, 10)
                                    : "Date",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 160,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select time slot',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 160,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(Maincolor.value),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            value: selectedTimeSlot1,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTimeSlot1 = newValue!;
                              });
                            },
                            items: <String>[
                              '9:00 AM - 12:00 PM',
                              '12:00 PM - 3:00 PM',
                              '3:00 PM - 6:00 PM',
                              // Add more time slot options as needed
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 20),
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 160,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(Whitecolr.value),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: DropdownButton<String>(
                            value: selectedTimeSlot2,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTimeSlot2 = newValue!;
                              });
                            },
                            items: <String>[
                              '9:00 AM - 12:00 PM',
                              '12:00 PM - 3:00 PM',
                              '3:00 PM - 6:00 PM',
                              // Add more time slot options as needed
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 20),
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: isOrderButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(
                        selectedFuelType: selectedFuelType!,
                        selectedQuantity: selectedQuantity!,
                        selectedDate: selectedDate!,
                        selectedTimeSlot: selectedTimeSlot1 ?? selectedTimeSlot2!,
                        selectedLocationName: _selectedLocationName, // Pass selectedLocation here
                      ),
                    ),
                  );
                }
                    : null,
                child: Container(
                  height: 60,
                  width: 400,
                  decoration: BoxDecoration(
                    color: isOrderButtonEnabled
                        ? Color(kPrimaryColor.value)
                        : Colors.grey, // Change color when button is disabled
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      isOrderButtonEnabled
                          ? "Order"
                          : "Please select all required items to proceed",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionIcon extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  OptionIcon({
    this.icon,
    required this.title,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          border: title == 'Maintenance'
              ? null
              : Border.all(color: Color(blackcolr.value)),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 70.0,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
