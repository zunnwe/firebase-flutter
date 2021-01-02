import 'dart:io';

class Users {

  final String uid;

  Users({ this.uid });
}

class UserData {

  final String uid;
  final File pdf_url;
  final String pdf_path;

  UserData({ this.uid, this.pdf_url, this.pdf_path});

}


