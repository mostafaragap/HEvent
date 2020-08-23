// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

//  class Charts extends StatefulWidget{
//    @override
//    State<StatefulWidget> createState() {
    
//     return ChartState();
//   }

//  }

//   class ChartState extends State<Charts >{
 
//   List<charts.Series<Attendees,String>>_attendeesChart;
//   List<charts.Series<Joined,String>>_joinedChart;
//    List<charts.Series<Eventchart,int>>_eventchart;
//       generatdata(){
//          var data=[
//         Attendees('sun',0 ,Color(0xff3366cc)),
//           Attendees('mon', 0,Color(0xff3366cc)),
//             Attendees('tues', 0,Color(0xff3366cc)),
//               Attendees('wednes', 0,Color(0xff3366cc)),
//                 Attendees('thurs', 0,Color(0xff3366cc)),
//                   Attendees('fri', 0,Color(0xff3366cc)),
//                     Attendees('satur', 0,Color(0xff3366cc)),
          
          
//                    ];
       
//       _attendeesChart.add(
//              charts.Series(
//                 domainFn: (Attendees attendees,_)=>attendees.day,
//                 measureFn: (Attendees attendees,_)=>attendees.figure,
//                 colorFn:(Attendees attendees,_)=>charts.ColorUtil.fromDartColor(attendees.colorval) ,
//                 id: '2018',
//                 data: data,
//                 labelAccessorFn:  (Attendees attendees,_)=>'${attendees.day}:${attendees.figure.toString()}'
//                            )                  
//                       );   

//          var data1=[
//          Joined('sun', 0,Color(0xff3366cc)),
//             Joined('mon', 0,Color(0xff3366cc)),
//               Joined('tues', 0,Color(0xff3366cc)),
//                 Joined('wednes', 0,Color(0xff3366cc)),
//                  Joined('thurs', 0,Color(0xff3366cc)),
//                    Joined('fri', 0,Color(0xff3366cc)),
//                       Joined('satur', 0,Color(0xff3366cc)),
          
          
          
         
          
//                    ];
       
//      _joinedChart.add(
//              charts.Series(
//                 domainFn: ( Joined  joined,_)=>joined.day,
//                 measureFn: ( Joined joined,_)=> joined.figure,
//                 colorFn:( Joined joined,_)=>charts.ColorUtil.fromDartColor( joined.colorval) ,
//                 id: '2018',
//                 data: data1,
//                 labelAccessorFn:  (Joined joined,_)=>'${joined.day}:${joined.figure.toString()}'
//                            )                  
//                       );     
 
       
       
//          var data2=[
//           Eventchart(1, 0),
//              Eventchart(2, 0),
//                Eventchart(3, 9,),
//                  Eventchart(4, 2,),
//                    Eventchart(5, 0,),
//                      Eventchart(6, 0,),
//                        Eventchart(7, 0,), 
//                 ];
 
//     _eventchart.add(
//    charts.Series(
//            domainFn: (Eventchart eventchart,_)=>eventchart.day,
//            measureFn: (Eventchart eventchart,_)=>eventchart.figure,
//            colorFn: (Eventchart eventchart, _)=>charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      
//            id: '2020',
//            data: data2,
//            labelAccessorFn:  (Eventchart eventchart,_)=>'${eventchart.day}:${eventchart.figure.toString()}'
  
//         )              
// );
//   var data3=[
//            Eventchart(1, 30),
//              Eventchart(2, 40),
//                Eventchart(3, 69,),
//                  Eventchart(4, 82,),
//                    Eventchart(5, 50,),
//                      Eventchart(6, 90,),
//                        Eventchart(7, 10,), 
//                 ];
 
//     _eventchart.add(
//    charts.Series(
//            domainFn: (Eventchart eventchart,_)=>eventchart.day,
//            measureFn: (Eventchart eventchart,_)=>eventchart.figure,
//            colorFn: (Eventchart eventchart, _)=>charts.ColorUtil.fromDartColor(Color(  0xff990099  )),
      
//            id: '2020',
//            data: data3,
//            labelAccessorFn:  (Eventchart eventchart,_)=>'${eventchart.day}:${eventchart.figure.toString()}'
  
//         )              
// );

  

//   }
  



// @override
// void initState(){
//   super.initState();
//   _attendeesChart = List<charts.Series<Attendees,String>>();
//    _joinedChart= List<charts.Series<Joined,String>>();
//     _eventchart= List<charts.Series<Eventchart,int>>();
  

//    generatdata();

// }

   
//  Widget build(BuildContext context){
//         return DefaultTabController(
           
//           length: 3,
//           child: Scaffold(
//             backgroundColor: Colors.white60,
//             appBar: AppBar(
//               title:Text('Event charts'),
//               centerTitle: true,
//               bottom: TabBar(
//                 isScrollable: true,
//                 tabs: <Widget>[
//                   Tab(
//                     child:Text('Attendees'),
//                     icon:Icon(Icons.assessment)
//                   ),
//                   Tab(
//                     child:Text('Joined'),
//                     icon:Icon(Icons.assessment)
//                   ),
//                   Tab(
//                     child:Text('finaly'),
//                     icon:Icon(Icons.assessment)
//                   ),
//                 ],
//               ),
//             ),

//       body:TabBarView(
//         children:  <Widget>[
        
//            Padding(
//             padding:EdgeInsets.all(20),
//             child: Center(
//               child:Column(
//                 children:<Widget>[
//                   Text('Number OF Attendees'),
//                   Expanded(
//                     child:charts.BarChart(
                         
//                           _attendeesChart
//                           )
//                      )
//                 ]
//               )
//             ),
//             ),
            

//                Padding(
//             padding:EdgeInsets.all(20),
//             child: Center(
//               child:Column(
//                 children:<Widget>[
//                   Text('Number OF joined'),
//                   Expanded(
//                     child:charts.BarChart(
//                           _joinedChart,

//                           )
//                      )
//                 ]
//               )
//             ),
//             ),
            
            
//              Padding(
//             padding:EdgeInsets.all(20),
//             child: Center(
//               child:Column(
//                 children:<Widget>[
//                   Text('Event Population'),
//                  Expanded(
//                      child:charts.LineChart(
//                     _eventchart,
//                        animate: true,
//                        animationDuration: Duration(seconds: 5),
//                        defaultRenderer: charts.LineRendererConfig(
//                          includeArea: true,
//                          stacked: true,
//                        ),
//                        behaviors: [
//                          charts.ChartTitle('event',
//                          behaviorPosition: charts.BehaviorPosition.bottom,
//                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
//                           charts.ChartTitle('Joined',
//                          behaviorPosition: charts.BehaviorPosition.start,
//                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
//                           charts.ChartTitle('attendees',
//                          behaviorPosition: charts.BehaviorPosition.end,
//                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
//                        ]
                         
                       

//                      )
//                      )
//                 ]
//               )
//             ),
//             ),

           
//         ]
                  
//       )
//           ),
//         );

//       }
//     }
// class  Attendees{

//     final String day;
//     final int figure;
//     Color colorval;
   
//  Attendees (this.day,this.figure,this.colorval);
//   }
  
  
//   class Joined {

//     final String day;
//     final int figure;
//      Color colorval;
   
//  Joined(this.day,this.figure,this.colorval);
//  }

//  class Eventchart {

//     final int day;
//     final int figure;
   
//  Eventchart (this.day,this.figure,);
//  }
  
  
