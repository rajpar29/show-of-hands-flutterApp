import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:show_of_hands/Services/service.dart';
import 'package:show_of_hands/models/pollsBrowse/pollModel.dart';

class CommentOverlay extends StatefulWidget {
  List<PollModel> pollList;
  Function updatePoll;
  int index;
  PollModel poll;
  CommentOverlay(this.pollList,this.index,this.updatePoll){
    poll = pollList[index];
  }

  @override
  State<StatefulWidget> createState() {
    return CommentOverlayState();
  }
}

class CommentOverlayState extends State<CommentOverlay> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
      ),
      body: _buildCommentSection(),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: TextFormField(
            controller: commentController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: createComment,
                  icon: Icon(Icons.send),
                ),
                prefixIcon: Icon(Icons.comment),
                border: OutlineInputBorder(),
                hintText: 'New Comment'),
          ),
        ),
      ),
    );
  }

  _buildCommentSection() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.poll.comments.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(4),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.poll.comments[index].username,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    widget.poll.comments[index].comment,
                    style: TextStyle(fontSize: 24, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        );
      },

      // Flexible(
      //   child: Container(),
      // ),
    );
  }

  createComment() async {
    print(commentController.text);
    Response response =
        await Service().createComment(commentController.text, widget.poll.id);
    if (response.statusCode == 200) {
      PollModel newPoll = PollModel.fromJson(jsonDecode(response.body));
      setState(() {
        widget.poll = newPoll;
        widget.updatePoll(widget.poll,widget.index);
      });
    }
    commentController.clear();
  }
}
