import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
class MapWithSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container in the background
        Container(
          height:200,
          width: 600,

          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10)

          ),
           // Background color for the container
          child: Center(
            child: Text(
              'Google Map', // Text inside the container (you can replace with Google Map)
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        // Search bar at the top center
        Positioned(
          top: 20.0,
          left: 15.0,
          right: 15.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
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
            child: Row(
              children: [
                // Search icon on the left
                Icon(Icons.search, color: Colors.black,size: 40,),
                SizedBox(width: 10.0),
                // Search text in the center
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for fuel',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Google Map icon on the right
                Icon(Icons.map,color: Colors.black,size: 40,),
              ],
            ),
          ),
        ),

      ],
    );
  }
}