import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://still-lowlands-97901.herokuapp.com/notes";

  //static -> to use it without maing instance
  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
    //log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  //fetching data from db to show in ui
  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    //jsonDecode(response.body);
    //print(decoded.toString());
    //print(decoded.toString());
    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }
}
