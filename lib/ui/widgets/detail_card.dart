import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String label;
  final String data;
  final Color color;

  DetailCard({@required this.label, @required this.data, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 45),
      leading: Text(
        label,
        style: TextStyle(fontSize: 19, color: Colors.grey[300]),
      ),
      trailing: Text(
        data,
        style: TextStyle(fontSize: 19, color: color),
      ),
    );
  }
}
