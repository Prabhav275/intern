import 'package:flutter/material.dart';
import 'models/flashcard.dart';

class AddFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;
  final Function(Flashcard) onAdd;
  final Function(Flashcard) onEdit;

  AddFlashcardScreen({Key? key, this.flashcard, required this.onAdd, required this.onEdit}) : super(key: key);

  @override
  _AddFlashcardScreenState createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _question;
  late String _answer;

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _question = widget.flashcard!.question;
      _answer = widget.flashcard!.answer;
    } else {
      _question = '';
      _answer = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Question'),
                initialValue: _question,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
                onChanged: (value) {
                  _question = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Answer'),
                initialValue: _answer,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
                onChanged: (value) {
                  _answer = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final flashcard = Flashcard(question: _question, answer: _answer);
                    if (widget.flashcard == null) {
                      widget.onAdd(flashcard);
                    } else {
                      widget.onEdit(flashcard);
                    }
                    Navigator.pop(context,flashcard);
                  }
                },
                child: Text(widget.flashcard == null ? 'Add Flashcard' : 'Update Flashcard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}