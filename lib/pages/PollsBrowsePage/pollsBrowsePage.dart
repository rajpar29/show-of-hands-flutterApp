import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:show_of_hands/Services/service.dart';
import 'package:show_of_hands/models/pollsBrowse/pollModel.dart';
import 'package:show_of_hands/pages/PollsBrowsePage/commentPage.dart';

class PollsBrowsePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PollsBrowsePageState();
}

class PollsBrowsePageState extends State {
  List<PollModel> polls;
  var currentUser;

  @override
  initState() {
    super.initState();
    getCurrentUser().then((data) {
      Service().getAllPolls().then((pollList) {
        setState(() {
          this.polls = pollList;
        });
      });
    });
  }

  getCurrentUser() async {
    currentUser = await Service().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
      ),
      body: polls == null
          ? Center(child: CircularProgressIndicator())
          : _buildPollList(),
    );
  }

  _buildPollList() {
    return ListView.builder(
      itemCount: polls.length,
      itemBuilder: (context, index) => _buildPollitem(index),
    );
  }

  _buildPollitem(int index) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCardHeader(index),
              _buildTitle(polls[index].title),
              _buildDescription(polls[index].description),
              _buildOptions(polls[index].options, index),
              _buildCardFooter(index)
            ],
          ),
        ),
      ),
    );
  }

  _buildCardHeader(index) {
    return Row(
      children: <Widget>[
        Text(
          polls[index].username + "-",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  _buildCardFooter(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Text(polls[index].comments.length.toString() + " Comments"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CommentOverlay(polls, index, commentAdded)));
          },
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(FontAwesomeIcons.arrowUp),
                color: arrowColor("upvote", index),
                onPressed: () => upvotePressed(index)),
            Text((polls[index].upvotes - polls[index].downvotes).toString()),
            IconButton(
              icon: Icon(FontAwesomeIcons.arrowDown),
              color: arrowColor("downvote", index),
              onPressed: () => downvotePressed(index),
            )
          ],
        )
      ],
    );
  }

  commentAdded(PollModel poll, int index) {
    setState(() {
      polls[index] = poll;
    });
  }

  _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black87, fontSize: 22),
    );
  }

  _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(color: Colors.black87, fontSize: 16),
    );
  }

  _buildOptions(List<Option> optionList, int pollIndex) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: optionList.length,
        itemBuilder: (BuildContext context, int index) {
          
          return buttonType(optionList[index], index, pollIndex)
              ? RaisedButton(
                  child: Text(optionList[index].optionName),
                  color: Colors.blueAccent,
                  onPressed: () {},
                )
              : OutlineButton(
                  child: Text(optionList[index].optionName),
                  onPressed: () {},
                  borderSide: BorderSide(
                    //  color: buttonColor(optionList[index], index, pollIndex),
                    color: Colors.blueAccent,
                    width: 1.3,
                    style: BorderStyle.solid, //Style of the border
                  ),
                );
        });
  }

  bool buttonType(Option option, int index, int pollIndex) {
    OptionChoosen userOption = ifUserChooseOption(polls[pollIndex]);
    if (userOption != null) {
      //print("in buttonVOlor options name is" + userOption.optionName);
    //  print(option.optionName +
          (userOption.optionName == option.optionName).toString());
      return userOption.optionName == option.optionName;

    } else {
    //  print("In Grey");
      return false;
    }
  }

  OptionChoosen ifUserChooseOption(PollModel poll) {
    for (var tempUser in poll.optionChoosen) {
      if (currentUser["username"] == tempUser.username) {
    // //    print("option Choosen = " +
    //         tempUser.optionName +
    //         "by " +
    //         tempUser.username);
        return tempUser;
        // print("upvoted" + tempUser.upvoted.toString());
        // print("downvoted" + tempUser.downvoted.toString());
      }
    }
  }

  upvotePressed(int index) async {
    PollModel newPoll = await Service().upvote(polls[index].id);
    polls[index] = newPoll;
    setState(() {
      var user = ifUserUpvotedorDownvoted(polls[index]);
    });
  }

  downvotePressed(int index) async {
    PollModel newPoll = await Service().downvote(polls[index].id);
    polls[index] = newPoll;
    setState(() {
      var user = ifUserUpvotedorDownvoted(polls[index]);
    });
  }

  ifUserUpvotedorDownvoted(PollModel poll) {
    for (var tempUser in poll.upvoteOrDownvotedBy) {
      if (currentUser["username"] == tempUser.username) {
        return tempUser;
        // print("upvoted" + tempUser.upvoted.toString());
        // print("downvoted" + tempUser.downvoted.toString());
      }
    }
  }

  arrowColor(String voteType, int index) {
    if (ifUserUpvotedorDownvoted(polls[index]) != null) {
      if (voteType == "upvote") {
        return ifUserUpvotedorDownvoted(polls[index]).upvoted
            ? Colors.redAccent
            : Colors.grey;
      }
      if (voteType == "downvote") {
        return ifUserUpvotedorDownvoted(polls[index]).downvoted
            ? Colors.blueAccent
            : Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }
}
