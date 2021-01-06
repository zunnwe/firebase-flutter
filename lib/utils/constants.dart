import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

const buildEmailField = InputDecoration(
  filled: true,
  fillColor: Colors.white70,
  icon: Icon(
      Icons.email,
      color: Colors.blueGrey
  ),
  hintText: ('Enter your email'),
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(10.0)
      ),
      borderSide: BorderSide.none
  ),
);

const buildPasswordField = InputDecoration(
    filled: true,
    fillColor: Colors.white70,
    icon: Icon(
        Icons.vpn_key,
        color: Colors.blueGrey
    ),
    hintText: ('Enter your password'),
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        )
    )
);

const buildUsernameField = InputDecoration(
    filled: true,
    fillColor: Colors.white70,
    icon: Icon(
        Icons.vpn_key,
        color: Colors.blueGrey
    ),
    hintText: ('Enter your name'),
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        )
    )
);

const buttonTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 15.0
);
