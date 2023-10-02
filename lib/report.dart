import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';


class chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Chart Example'),
        ),
        body: FirestoreChart(),
      ),
    );
  }
}

class FirestoreChart extends StatelessWidget {
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('PRODUCT')
        .get();
    return snapshot;
  }

  List<FlSpot> transformData(QuerySnapshot<Map<String, dynamic>> data) {
    List<FlSpot> spots = [];
    for (var document in data.docs) {
      final x = document['Product_Name']; // Replace with your field name
      final y = document['Product_Price']; // Replace with your field name
      spots.add(FlSpot(x.toDouble(), y.toDouble()));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator()); // Loading indicator
        }
        final data = snapshot.data!;
        final spots = transformData(data);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              minX: 0,
              maxX: 10, // Adjust this based on your data
              minY: 0,
              maxY: 100, // Adjust this based on your data
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  colors: [Colors.blue],
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}