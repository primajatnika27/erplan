import 'package:flutter/material.dart';

class BlockLoader extends StatelessWidget {
  final String message;

  BlockLoader({this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 16.0,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        return Future<bool>.value(false);
      },
    );
  }
}
