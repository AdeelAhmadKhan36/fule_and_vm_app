import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:fule_and_vm_app/widgets/appbar.dart';
import 'package:fule_and_vm_app/widgets/mapwithSearchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedQuantity;
  DateTime? selectedDate;

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
    text: 'Welcome Adeel Ahmad',
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
    SizedBox(width: 4),
    ReusableText(
    text: "Mansehra KPK Pakistan",
    style: TextStyle(color: Colors.grey),
    ),
    ],
    ),
    SizedBox(height: 20),
    MapWithSearchBar(),
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
    print("Maintenance is Pressed");
    },
    ),
    OptionIcon(
    icon: Icons.local_gas_station_outlined,
    title: "Petrol",
    color: Color(Whitecolr.value),
    onPressed: () {},
    ),
    OptionIcon(
    icon: Icons.bike_scooter,
    title: "Diesel",
    color: Color(Whitecolr.value),
    onPressed: () {},
    ),
    OptionIcon(
    icon: Icons.directions_walk,
    title: "Engine Oil",
    color: Color(Whitecolr.value),
    onPressed: () {},
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    SizedBox(height: 10),
    Container(
    padding: EdgeInsets.all(16.0),
    height: 250,
    width: 400,
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
    'Choose your requirement for fuel',
    style: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(
    height: 10,
    ),
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
    Text(
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
    title: Text(
    '$quantity Liters'),
    onTap: () {
    setState(() {
    selectedQuantity =
    quantity;
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
    "Quantity (Lts)",
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    ),
    ),
    ),
    ),
    ),
    SizedBox(
    width: 10,
    ),
    Container(
    width: 160,
    height: 130,
    decoration: BoxDecoration(
    color: Color(Whitecolr.value),
    borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
    onTap: () {
    // Show date picker

      _selectDate(context);
    },
      child: Center(
        child: Text(
          selectedDate != null
              ? selectedDate!.toString().substring(0, 10)
              : "Date",
          style: TextStyle(
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
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(blackcolr.value)),
          boxShadow: [
            BoxShadow(
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
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    title,
                    style: TextStyle(
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
