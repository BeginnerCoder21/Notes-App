import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/add_new_note.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const Color bluishClr = Color(0xFF600CCF);
    const Color yelloClr = Color(0xFFFFBE30);
    const Color pinkClr = Color(0xffFF0B6B);
    const Color white = Colors.white;
    const primaryClr = bluishClr;
    const Color darkGreayClr = Color(0xff303030);
    const Color darkHeaderClr = Color.fromARGB(255, 49, 49, 49);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 242, 222),
      body: SizedBox(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(60.0),
                  bottomRight: const Radius.circular(60.0),
                ),
              ),
              child: Image(
                image: AssetImage('assets/Board2.gif'),
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
                height: 350,
              ),
            ),
            //Heading and 3 colors
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.49),
                  child: Text(
                    "J O T T I N G",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: darkGreayClr,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * 0.1),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: bluishClr,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      // margin: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * 0.1),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: yelloClr,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      // margin: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * 0.41),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: pinkClr,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //Content Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.65),
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Text(
                        "Jot down your important things",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          color: darkGreayClr,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Text(
                            "Write down anything you want",
                            style: GoogleFonts.poppins(
                              color: darkGreayClr,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "Select your custom colors for a note",
                            style: GoogleFonts.poppins(
                              color: darkGreayClr,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //Button
            Container(
              width: 120,
              height: 40,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.90,
                left: 350,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => NotesPage(),
                    ),
                  );
                },
                child: Text(
                  'Get Started',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 82, 31, 157),
                  primary: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
