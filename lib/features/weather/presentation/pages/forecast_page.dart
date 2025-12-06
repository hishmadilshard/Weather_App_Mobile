// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/core/theme/colors.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('5-Day Forecast'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTemperatureChart(),
                const SizedBox(height: 30),
                _buildForecastList(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SfCartesianChart(
        title: ChartTitle(text: 'Temperature Trend'),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Temperature (°C)'),
        ),
        series: <LineSeries<ChartData, String>>[
          LineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.temp,
            name: 'Max Temp',
            color: Colors.red,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
          LineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.temp - 5,
            name: 'Min Temp',
            color: Colors.blue,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  Widget _buildForecastList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Forecast',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...forecastData.map((forecast) => _buildForecastItem(forecast)),
      ],
    );
  }

  Widget _buildForecastItem(Map<String, dynamic> forecast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              forecast['day'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Image.asset(
            forecast['icon'],
            width: 40,
            height: 40,
          ),
          const Spacer(),
          Text(
            '${forecast['maxTemp']}°',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${forecast['minTemp']}°',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            forecast['condition'],
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.temp);
  final String day;
  final double temp;
}

final List<ChartData> chartData = [
  ChartData('Mon', 22),
  ChartData('Tue', 24),
  ChartData('Wed', 21),
  ChartData('Thu', 19),
  ChartData('Fri', 23),
  ChartData('Sat', 25),
  ChartData('Sun', 26),
];

final List<Map<String, dynamic>> forecastData = [
  {
    'day': 'Today',
    'icon': 'assets/images/sunny.png',
    'maxTemp': 25,
    'minTemp': 18,
    'condition': 'Sunny',
  },
  {
    'day': 'Tomorrow',
    'icon': 'assets/images/partly_cloudy.png',
    'maxTemp': 23,
    'minTemp': 17,
    'condition': 'Partly Cloudy',
  },
  {
    'day': 'Wednesday',
    'icon': 'assets/images/cloudy.png',
    'maxTemp': 21,
    'minTemp': 16,
    'condition': 'Cloudy',
  },
  {
    'day': 'Thursday',
    'icon': 'assets/images/rainy.png',
    'maxTemp': 19,
    'minTemp': 15,
    'condition': 'Rainy',
  },
  {
    'day': 'Friday',
    'icon': 'assets/images/partly_cloudy.png',
    'maxTemp': 22,
    'minTemp': 17,
    'condition': 'Partly Cloudy',
  },
];