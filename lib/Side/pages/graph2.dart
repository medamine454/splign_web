import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphic extends StatefulWidget {
  List<ChartData> data_points;
  Graphic({Key? key, required this.data_points}) : super(key: key);

  @override
  State<Graphic> createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: SfCartesianChart(
                enableAxisAnimation: true,
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
          // Initialize line series
          LineSeries<ChartData, String>(
              dataSource: widget.data_points
              /*[
                // Bind data source
                ChartData('Jan', 0),
                ChartData('Feb', 1),
                ChartData('Mar', 0),
                ChartData('Apr', 0),
                ChartData('May', 1)
              ]*/
              ,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // Render the data label
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ])));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
