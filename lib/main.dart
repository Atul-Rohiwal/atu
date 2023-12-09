import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CWPage("1", 5, 5), // Adjust parameters accordingly
    );
  }
}

class CWPage extends StatefulWidget {
  final String thisCW;
  final int rows;
  final int cols;

  CWPage(this.thisCW, this.rows, this.cols);

  @override
  _CWPageState createState() => _CWPageState(thisCW, rows, cols);
}

class _CWPageState extends State<CWPage> {
  final String thisCW;
  final int rows;
  final int cols;

  _CWPageState(this.thisCW, this.rows, this.cols);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crossword #$thisCW'),
      ),
      body: Center(
        child: CrosswordPuzzle(
          rows: rows,
          cols: cols,
          words: [
            CrosswordWord("example", 0, 0, true),
            CrosswordWord("flutter", 1, 1, false),
            // Add more words as needed
          ],
        ),
      ),
    );
  }
}

class CrosswordWord {
  final String word;
  final int startX;
  final int startY;
  final bool isVertical;

  CrosswordWord(this.word, this.startX, this.startY, this.isVertical);
}

class CrosswordPuzzle extends StatelessWidget {
  final int rows;
  final int cols;
  final List<CrosswordWord> words;

  CrosswordPuzzle({required this.rows, required this.cols, required this.words});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
      ),
      itemCount: rows * cols,
      itemBuilder: (context, index) {
        // Check if the current cell is part of any word
        var word = words.firstWhere(
              (word) =>
          (word.isVertical &&
              word.startX == index % cols &&
              word.startY <= index / cols && // Check if within word range
              index / cols < word.startY + word.word.length) ||
              (!word.isVertical &&
                  word.startY == index / cols &&
                  word.startX <= index % cols && // Check if within word range
                  index % cols < word.startX + word.word.length),
          orElse: () => CrosswordWord("", 0, 0, false),
        );

        return Container(
          decoration: BoxDecoration(
            border: Border.all(),
            color: word.word.isNotEmpty ? Colors.yellow : Colors.white,
          ),
          child: Center(
            child: Text(
              word.word.isNotEmpty ? word.word[0] : '',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
