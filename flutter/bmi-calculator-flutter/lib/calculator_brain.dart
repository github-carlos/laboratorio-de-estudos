import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});
  final int height;
  final int weight;

  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi > 25) {
      return 'Acima do Peso';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Abaixo do Peso';
    }
  }

  String getInterpretation() {
    if (_bmi > 25) {
      return 'Você está com um peso acima do esperado. Tente se exercitar mais!';
    } else if (_bmi > 18.5) {
      return 'Você está com o peso normal. Bom trabalho!';
    } else {
      return 'Você está abaixo do peso. Tente se alimentar melhor.';
    }
  }
}