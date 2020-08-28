import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWords> {
  final wordpair = <WordPair>[];
  final Set<WordPair> savedwords = {};

  Widget buildlist() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, item) {
        if (item.isOdd) {
          return Divider();
        }
        final index = item ~/ 2;

        if (index >= wordpair.length) {
          wordpair.addAll(generateWordPairs().take(10));
        }

        return buildrow(wordpair[index]);
      },
    );
  }

  Widget buildrow(WordPair pair) {
    final already = savedwords.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 16.0, color: Colors.red),
      ),
      trailing: Icon(already ? Icons.favorite : Icons.favorite_border,
          color: already ? Colors.red : null),
      onTap: () {
        setState(() {
          if (already) {
            savedwords.remove(pair);
          } else {
            savedwords.add(pair);
          }
        });
      },
    );
  }

  void push_stack() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final tiles = savedwords.map((element) {
          return ListTile(
            title: Text(
              element.asPascalCase,
              style: TextStyle(fontSize: 20),
            ),
          );
        });
        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text("Saved Word Pairs"),
          ),
          body: ListView(
            children: divided,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Word Pair Generator"), actions: [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: push_stack,
        )
      ]),
      body: buildlist(),
    );
  }
}
