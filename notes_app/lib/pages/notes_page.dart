import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/pages/add_new_note.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'theme.dart';
import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: _appBar(),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: (notesProvider.notes.length > 0)
                  ? ListView(
                      children: [
                        _addTaskBar(),
                        Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                searchQuery = val;
                              });
                            },
                            cursorColor: Colors.grey[700],
                            style: subTitleStyle,
                            decoration: const InputDecoration(
                              hintText: "Search notes",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 1,

                                  //style: BorderStyle(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        (notesProvider.searchNotes(searchQuery).length > 0)
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // gridDelegate:
                                //     SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount: 2),
                                itemCount: notesProvider
                                    .searchNotes(searchQuery)
                                    .length,
                                itemBuilder: (context, index) {
                                  //Note currNote =notesProvider.notes[index];
                                  Note currNote = notesProvider
                                      .searchNotes(searchQuery)[index];
                                  return GestureDetector(
                                    onTap: () {
                                      //Update
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => AddNewNote(
                                            isUpdate: true,
                                            note: currNote,
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      //Delete
                                      notesProvider.deleteNote(currNote);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20, top: 10),
                                      padding: const EdgeInsets.all(15),
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: yelloClr,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            currNote.title!,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              //Update and delte icons
                                              Container(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddNewNote(
                                                              isUpdate: true,
                                                              note: currNote,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.white,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        textStyle: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Edit',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .pen,
                                                            semanticLabel:
                                                                "Pen",
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    TextButton.icon(
                                                      onPressed: () {
                                                        notesProvider
                                                            .deleteNote(
                                                                currNote);
                                                      },
                                                      label: Text(''),
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .xmarkCircle,
                                                        color: Color.fromARGB(
                                                            255, 182, 0, 0),
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 5,
                                            ),
                                          ),
                                          Text(
                                            currNote.content!,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text("No notes found"),
                              ),
                      ],
                    )
                  : Column(
                      children: [
                        _addTaskBar(),
                        Container(
                          margin: EdgeInsets.only(top: 90),
                          child: Column(
                            children: [
                              Image(
                                alignment: Alignment.center,
                                image: AssetImage(
                                  'assets/no_note.png',
                                ),
                                height: 300,
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'To add new note click on ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '+Add Task',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' button'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          //ThemeService().switchTheme();
          print('Tapped');
        },
        child: Icon(
          Icons.nightlight_round,
          color: Get.isDarkMode ? Colors.black : Colors.black,
          size: 20,
        ),
      ),
      actions: [
        //can add icons on appbar from right side
        // Icon(
        //   Icons.nightlight_round,
        //   size: 20,
        // ),
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //DateTime.now().toString(),
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Today',
                  style: headingStyle,
                ),
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            width: 100,
            height: 40,
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, 'addNote'),
              child: Text(
                "+ Add Task",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: primaryClr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get headingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
      ),
    );
  }
}
