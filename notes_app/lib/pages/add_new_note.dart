import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:notes_app/pages/theme.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';
import 'input_feild.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNote({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  //final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = "Daily";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Note',
                  style: headingStyle,
                ),
                InputFeild(
                  title: "Title",
                  hint: "Enter title here",
                  controller: _titleController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Note",
                  style: titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 14),
                  height: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Your note',
                      hintStyle: subTitleStyle,
                    ),
                    cursorColor: Colors.grey[700],
                    controller: _noteController,
                    style: subTitleStyle,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                // InputFeild(
                //   title: "Note",
                //   hint: "Enter your note",
                //   controller: _noteController,
                // ),
                InputFeild(
                  title: "Date",
                  hint: DateFormat.yMMMd().format(_selectedDate),
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_month_sharp,
                      color: Color.fromARGB(255, 92, 92, 92),
                    ),
                    onPressed: () {
                      _getDate();
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPalette(),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          // if (widget.isUpdate) {
                          //   updateNote();
                          // } else if (widget.isUpdate == false) {
                          //   addNewNote();
                          // }
                          _validateData();
                        },
                        child: Text(
                          'Done \u{1F44D}',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(), //gives unique id automatically
      userid: "anushka@gmail.com",
      title: _titleController.text,
      content: _noteController.text,
      dateAdded: _selectedDate,
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = _titleController.text;
    widget.note!.content = _noteController.text;
    widget.note!.dateAdded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  //To take data back for updating it
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      _titleController.text = widget.note!.title!;
      _noteController.text = widget.note!.content!;
    }
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

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yelloClr,
                    child: _selectedColor == index
                        ? CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.white,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          //Get.back();
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NotesPage(),
            ),
          );
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Get.isDarkMode ? Colors.black : Colors.black,
          size: 24,
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

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2024),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Something went wrong!!");
    }
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      if (widget.isUpdate) {
        updateNote();
      } else if (widget.isUpdate == false) {
        addNewNote();
      }
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      final snackbar = SnackBar(
        content: Text(
          "Title and note is required",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 3),
        elevation: 4,
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,

        //snackPosition: SnackPosition.BOTTOM,

        // icon: Icon(
        //   Icons.warning_amber_rounded,
        //   color: Colors.red,
        // ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
