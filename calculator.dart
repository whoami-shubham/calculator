import 'package:flutter/material.dart';

class Calculator extends StatefulWidget{

  @override 
  createState() => _Calculator();
}



class _Calculator extends State<Calculator>{
  var result = "0";
  var leftOperand  = "0";
  var rightOperand = "";
  var oprator =  "";
  var dot = false;

   void setResult(String val){
     setState(() {
       result = val;
     });
   }

   void clickHandler(String name){
     final List operators = ['+','-','%','÷','×'];
     if(operators.contains(name)){
       if(oprator.length==0){
          setResult(result+name);
          oprator = name; 
          dot = false;
       }
     }
     else if(name=="AC"){
       oprator = "";
       leftOperand  = "0";
       rightOperand = "";
       setResult("0");
     }
     else if(name=="\u232B"){ // backspace
         if (rightOperand.length>0 || leftOperand.length>0){
            if(rightOperand.length>0){
              rightOperand = rightOperand.substring(0,rightOperand.length-1);
            }
            else{
                if(leftOperand.length>0){
                   leftOperand = leftOperand.length>1?leftOperand.substring(0,leftOperand.length-1):"0";
                }
            }
            setResult(leftOperand + oprator + rightOperand);
         }
     }
     else if(name=='='){
           if(leftOperand.length>0 && rightOperand.length>0){
               setResult(cal(double.parse(leftOperand),double.parse(rightOperand),oprator));
               leftOperand = result;
               rightOperand = "";
               oprator = "";
               dot = false;
           }
     }
     else{
        //  if((name=="." && dot) || (name=="0" && (oprator.length==0 && leftOperand=="0"||leftOperand.length==0) || (oprator.length>0 && rightOperand=="0"||rightOperand.length==0))){
        //        return;
        //     }
            
        if(oprator.length==0){
            if(leftOperand=="0" && name!="0"){
               leftOperand = name=="."?leftOperand + name:name;
            }
            else{
              leftOperand = (name=="0" && leftOperand=="0")||(name=="." && dot)?leftOperand:leftOperand + name;
            }
        }
        else{
            rightOperand  = (name=="0" && rightOperand=="0")||(name=="." && dot)?rightOperand:rightOperand + name;
        }
        if(name=="." && !dot){
                 dot = true;
        }
        setResult(leftOperand + oprator + rightOperand);
     }
     print(result);
   }
   String cal(double op1,double op2,String op){
      if(op=='+'){
        return (op1+op2).toString();
      }
      else if(op=='-'){
         return (op1-op2).toString();
      }
      else if(op=='×'){
        return (op1*op2).toString();
      }
      else if(op=='÷'){
        return op2!=0?(op1/op2).toString():'NaN';
      }
      else{
        return (op1%op2).toString();
      }

   }

   Widget createButton(String name){
     return Expanded(
       child:SizedBox(
         height: 60,
         child: Padding(
                padding: EdgeInsets.all(2.0),
                child: RaisedButton(
                          onPressed:()=>clickHandler(name),
                          color: name=='='?Color.fromRGBO(252, 107, 3,1):Colors.white,
                          child: Text(name,style:TextStyle(fontSize: 20,color: name=='AC'?Color.fromRGBO(252, 107, 3,1):Colors.black)) ,
                        )
                      ,),
                  )
              );
   }
   @override
   Widget build(BuildContext context){
       return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text(result,style:TextStyle(fontSize: 40,),textAlign:TextAlign.right ,),
                    Column(
                      children: <Widget>[
                           Row(
                        children: <Widget>[
                        createButton("AC"),
                        createButton("\u232B"),
                        createButton("%"),
                        createButton("÷"),

                      ],
                    ),
                      Row(
                        children: <Widget>[
                        createButton("7"),
                        createButton("8"),
                        createButton("9"),
                        createButton("×"),

                      ],
                    ),
                      Row(
                        children: <Widget>[
                        createButton("4"),
                        createButton("5"),
                        createButton("6"),
                        createButton("-"),

                      ],
                    ),
                      Row(
                        children: <Widget>[
                        createButton("1"),
                        createButton("2"),
                        createButton("3"),
                        createButton("+"),

                      ],
                    ),
                      Row(
                        children: <Widget>[
                        createButton("AC"),
                        createButton("0"),
                        createButton("."),
                        createButton("="),

                      ],
                    ),
                      ],
                    ),

                    
                ],
              ),
       );
   }
}