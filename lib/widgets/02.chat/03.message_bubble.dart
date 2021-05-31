import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
final Key key;
final bool isMe;
final String username;
final String message;

  const MessageBubble({@required this.key, @required this.isMe, @required this.username, @required this.message}) ;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          width: 150,
          decoration: BoxDecoration(
            color: isMe? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: isMe? Radius.circular(15) : Radius.circular(0),
              bottomRight:isMe? Radius.circular(0) : Radius.circular(15),
            )
          ),
          child: Column(
            crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(username, style: TextStyle(fontWeight: FontWeight.bold , color: isMe? Colors.black : Theme.of(context).accentTextTheme.headline6.color,
              ), textAlign: isMe? TextAlign.end : TextAlign.start
              ),

              Text(message , style: TextStyle(color: isMe? Colors.black : Theme.of(context).accentTextTheme.headline6.color,
              ), textAlign: isMe? TextAlign.end : TextAlign.start
              ),
            ],
          ),
        
        )
      ],
    );
  }
}