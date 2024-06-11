import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/widgets/app.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class vehiclemaintenance_home extends StatefulWidget {
  const vehiclemaintenance_home({super.key});

  @override
  State<vehiclemaintenance_home> createState() => _vehiclemaintenance_homeState();
}

class _vehiclemaintenance_homeState extends State<vehiclemaintenance_home> {
  final _offersPageController = PageController();
  final _servicesPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(title: Text(
        "Maintenance Screen",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),),
      backgroundColor: primaryColor,
      body: Padding(
          padding: const EdgeInsets.only(top: 30,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              Text(
                                "Mansehra KPK,Pakistan",
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.notifications_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Add some spacing between the elements
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true, // Fill the background color
                            labelText: 'Search',
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              size: 24,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Special Offers",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("See All",
                                style: TextStyle(color: primaryColor)),
                          ],
                        ),
                        const SizedBox(
                            height: 20), // Space between the row and the PageView
                        Container(
                          height: 170, // Fixed height for the PageView
                          child: PageView(
                            controller: _offersPageController,
                            children: [
                              _buildPageContainer(Colors.grey.shade200, "Page 1"),
                              _buildPageContainer(Colors.grey.shade200, "Page 2"),
                              _buildPageContainer(Colors.grey.shade200, "Page 3"),
                              _buildPageContainer(Colors.grey.shade200, "Page 4"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _offersPageController,
                            count: 4,
                            effect: const WormEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.purple,
                              dotHeight: 10,
                              dotWidth: 10,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Services",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("See All",
                                style: TextStyle(color: primaryColor)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildServices(Icons.car_crash, "Car Inspect..."),
                            _buildServices(Icons.car_rental_rounded, "Tire Rotat..."),
                            _buildServices(Icons.oil_barrel_outlined, "Oil Chan...")
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Service Providers",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("See All",
                                style: TextStyle(color: primaryColor)),
                          ],
                        ),
                        const SizedBox(
                            height: 20), // Space between the row and the PageView
                        Container(
                          height: 170, // Fixed height for the PageView
                          child: PageView(
                            controller: _servicesPageController,
                            children: [
                              _buildServicePageContainer(Colors.grey.shade200, "Page 1"),
                              _buildServicePageContainer(Colors.grey.shade200, "Page 2"),
                              _buildServicePageContainer(Colors.grey.shade200, "Page 3"),
                              _buildServicePageContainer(Colors.grey.shade200, "Page 4"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _servicesPageController,
                            count: 4,
                            effect: const WormEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.purple,
                              dotHeight: 10,
                              dotWidth: 10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildPageContainer(Color color, String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 85,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: const Center(
                          child: Text("Today's Offers", style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text("Get Special Offer", style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                          Text("Up to"),
                          Text("20%",style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                      const SizedBox(height: 03,),
                      SingleChildScrollView(
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Center(
                            child: Text("Claim",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: 160,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("Assets/Images/pic2.jpeg")
                    ),
                    color: Colors.red,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(80), bottomLeft: Radius.circular(80))
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
  Widget _buildServicePageContainer(Color color, String text) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Image(
          fit: BoxFit.cover,
          image: AssetImage(
            "Assets/Images/pic1.jpeg",
          ),
        )
    );
  }

  Widget _buildServices(IconData icon, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.only(right: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade200),
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        const SizedBox(height: 06,),
        Text(label,style: const TextStyle(
            fontWeight: FontWeight.bold
        ),)
      ],
    );
  }
}

