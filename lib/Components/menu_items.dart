import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Text('Classroom',style: GoogleFonts.abel(fontWeight:FontWeight.bold),),
        ),
        Container(
          height: 50,
          child: Text('WaterSupply',style: GoogleFonts.abel(fontWeight:FontWeight.bold),),
        ),
        Container(
          height: 50,
          child: Text('Washroom',style: GoogleFonts.abel(fontWeight:FontWeight.bold),),
        ),
        Container(
          height: 50,
          child: Text('Computers',style: GoogleFonts.abel(fontWeight:FontWeight.bold),),
        ),
        Container(
          height: 50,
          child: Text('Other',style: GoogleFonts.abel(fontWeight:FontWeight.bold),),
        ),

      ],
    );
  }
}