import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bloodpressure_keeper_app/model/blood_pressure_chart_dto.dart';
import 'package:bloodpressure_keeper_app/utils/app_colors.dart';

class ComboBarLineChart extends StatelessWidget {
  final double width;
  final double height;
  final List<BloodPressureChartDto> systolicData ;
  final List<BloodPressureChartDto> diastoleData ;
  final List<BloodPressureChartDto> pulseData ;
  final Function(String data,int pulse) setOnclick ;

  const ComboBarLineChart({
    Key? key,
    required this.width,
    required this.height,
    required this.systolicData,
    required this.diastoleData,
    required this.pulseData,
    required this.setOnclick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: charts.OrdinalComboChart(_createSampleData(),
            animate: true,
            // Configure the default renderer as a bar renderer.
            defaultRenderer: new charts.LineRendererConfig(),
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                desiredMinTickCount: 6,
                desiredMaxTickCount: 6,
              ),
            ),
            customSeriesRenderers: [
              new charts.BarRendererConfig(
                  maxBarWidthPx : 14,
                  cornerStrategy: charts.ConstCornerStrategy(30),
                  customRendererId: 'customLine'),
              new charts.PointRendererConfig(
                  // symbolRenderer: CustomCircleSymbolRenderer(),
                  customRendererId: 'SystolicPoint'),
              new charts.PointRendererConfig(
                  customRendererId: 'DiastolePoint')
            ],
        selectionModels: [
          charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            updatedListener:(charts.SelectionModel<String> model){
              // charts.UserManagedSelectionModel(model: model) ;
              print('구르니??널이니?!!!!!!!!!!!!!!!!!!');
              final selectedDatum = model.selectedDatum;
              print('구르니?!!!!!!!?${selectedDatum.length}');
              if(selectedDatum.length > 0){
                setOnclick.call(selectedDatum[0].datum.checkFullData, selectedDatum[0].datum.pulse);
              }
            },
            changedListener: (charts.SelectionModel model){
              print('구르니??널이니?????????????');
              final selectedDatum = model.selectedDatum;
              print('구르니??${selectedDatum.first.datum.checkData}');
            }
          )
        ],));
  }

  /// Create series list with multiple series
  List<charts.Series<BloodPressureChartDto, String>> _createSampleData() {
    // final Color myRed = const Color(0xFFEB4141);
    // final Color myDarkBackground = const Color(0xFF101926);
    return [
      //수축
      new charts.Series<BloodPressureChartDto, String>(
          id: 'Systolic',
          // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,  Color(AppColors.colorBtnActivate)
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(AppColors.colorRedChartLine)),
          domainFn: (BloodPressureChartDto sales, _) => sales.checkData!,
          measureFn: (BloodPressureChartDto sales, _) => sales.systolic,
          data: systolicData),
      new charts.Series<BloodPressureChartDto, String>(
          id: 'SystolicPoint',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(AppColors.colorRedChartPoint)),
          domainFn: (BloodPressureChartDto sales, _) => sales.checkData!,
          measureFn: (BloodPressureChartDto sales, _) => sales.systolic,
          radiusPxFn: (BloodPressureChartDto sales, _) => 3.0,
          fillColorFn: (BloodPressureChartDto sales, _) => charts.MaterialPalette.white,
          strokeWidthPxFn: (BloodPressureChartDto sales, _) => 2.0,
          data: systolicData)
        ..setAttribute(charts.rendererIdKey, 'SystolicPoint'),

      //확장
      new charts.Series<BloodPressureChartDto, String>(
          id: 'Diastole',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(AppColors.colorBlueChartLine)),
          domainFn: (BloodPressureChartDto sales, _) => sales.checkData!,
          measureFn: (BloodPressureChartDto sales, _) => sales.diastole,
          data: diastoleData),
      new charts.Series<BloodPressureChartDto, String>(
          id: 'DiastolePoint',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(AppColors.colorBlueChartPoint)),
          domainFn: (BloodPressureChartDto sales, _) => sales.checkData!,
          measureFn: (BloodPressureChartDto sales, _) => sales.diastole,
          radiusPxFn: (BloodPressureChartDto sales, _) => 3.0,
          fillColorFn: (BloodPressureChartDto sales, _) => charts.MaterialPalette.white,
          strokeWidthPxFn: (BloodPressureChartDto sales, _) => 2.0,
          data: diastoleData)
        ..setAttribute(charts.rendererIdKey, 'DiastolePoint'),

      //심박수
      new charts.Series<BloodPressureChartDto, String>(
          id: 'Pulse ',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(AppColors.colorGreenChartLine)),
          domainFn: (BloodPressureChartDto sales, _) => sales.checkData!,
          measureFn: (BloodPressureChartDto sales, _) => sales.pulse,
          data: pulseData)
        ..setAttribute(charts.rendererIdKey, 'customLine'),

    ];
  }
}

//
// class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
//   @override
//   void paint(charts.ChartCanvas canvas,
//       Rectangle<num> bounds,
//       {List<int>? dashPattern,
//         charts.Color? fillColor,
//         charts.FillPatternType? fillPattern,
//         charts.Color? strokeColor,
//         double? strokeWidthPx}) {
//     // TODO: implement paint
//     super.paint(canvas, bounds,
//         dashPattern: dashPattern,
//         fillColor: fillColor,
//         fillPattern: fillPattern,
//         strokeColor: strokeColor,
//         strokeWidthPx: strokeWidthPx);
//
//       var textStyle = style.TextStyle();
//       textStyle.color = chart_color.Color.black;
//       textStyle.fontSize = 15;
//       canvas.drawText(te.TextElement('구른다.', style: textStyle),
//           (bounds.left).round(), (bounds.top - 28).round());
//   }
// }
