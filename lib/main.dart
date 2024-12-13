import 'package:flutter/material.dart';
import 'models/flashcard.dart';
import 'add_flashcard.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FlashcardList(),
    );
  }
}

class FlashcardList extends StatefulWidget {
  @override
  _FlashcardListState createState() => _FlashcardListState();
}

class _FlashcardListState extends State<FlashcardList> {
  List<Flashcard> flashcards = [];

  void addFlashcard(Flashcard flashcard) {
    setState(() {
      flashcards.add(flashcard);
    });
  }

  void editFlashcard(int index, Flashcard flashcard) {
    setState(() {
      flashcards[index] = flashcard;
    });
  }

  void deleteFlashcard(int index) {
    setState(() {
      flashcards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFlashcardScreen(
                    onAdd: addFlashcard, onEdit: (Flashcard ) {  },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(flashcards[index].question),
              subtitle: const Text('Tap to see answer'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Answer'),
                    content: Text(flashcards[index].answer),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFlashcardScreen(
                            flashcard: flashcards[index],
                            onEdit: (updatedFlashcard) {
                              editFlashcard(index, updatedFlashcard);
                              Navigator.pop(context);
                            }, onAdd: (Flashcard ) {  },
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Flashcard'),
                          content: const Text('Are you sure you want to delete this flashcard?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                deleteFlashcard(index);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}