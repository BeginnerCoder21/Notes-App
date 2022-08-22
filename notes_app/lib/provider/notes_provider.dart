import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  //Default Constructor
  NotesProvider() {
    fetchNotes();
  }
  List<Note> searchNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }

  void addNote(Note n) {
    notes.add(n);
    sortNotes();
    notifyListeners(); //App will get to know that note is added
    ApiService.addNote(n);
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(
      notes.firstWhere((element) => element.id == note.id),
    );
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(
      notes.firstWhere((element) => element.id == note.id),
    );
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("anushka@gmail.com");
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
