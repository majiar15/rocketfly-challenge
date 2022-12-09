

String numberToStringZero(int number){
  
  String numberZero = number.toString();
  
    for (var i = number.toString().length; i < 4; i++) {
      numberZero =  "0$numberZero" ;
    }
  return numberZero;
}