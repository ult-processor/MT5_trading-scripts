//+------------------------------------------------------------------+
//|                                                          HFT.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link "https://www.mql5.com"
#property version "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

#include  <Indicators\Trend.mqh>


#include <Trade\Trade.mqh>

CTrade trade;


///+++++++++++++++++++++++++++++++++++++++The begining of the  of the cadle state detection module+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///
string Detect_The_current_candle_state() {
  //---
  MqlRates PriceInformation[];
  //sort it from current to oldest candle
  ArraySetAsSeries(PriceInformation, true);

  //copy price data into the array
  int Data = CopyRates(_Symbol, Period(), 0, Bars(_Symbol, Period()), PriceInformation);
  string signal = "";

  //get the current open price
  double OpenPrice = PriceInformation[0].open;
  //get the current close price 
  double ClosePrice = PriceInformation[0].close;
  //the system will detect that the candle is profitable
  if (OpenPrice < ClosePrice) signal = "positive";
  // the system  will detect that the candle is not profitable
  if (ClosePrice < OpenPrice) signal = "negative";
  //chart output
  //Comment("Close price for candle 0:", ClosePrice, "\n", "Open price for candle 0:", OpenPrice, "\n", signal, "\n");

  //get the current open price
  //double OpenPrice = PriceInformation[0].open;
  //chart output
  //Comment ("Open price for candle 0:",OpenPrice);
  return signal;
}

///+++++++++++++++++++++++++++++++++++++++The End of the  of the candle state detection module++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///

///+++++++++++++++++++++++++++++++++++++++The begining of the  of the custom Timer module+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///
//string GetTime() {

  //create a chart output for time with seconds;

  //string TimeWithSeconds;

  //calculate time with seconds for local time
  //TimeWithSeconds = TimeToString(TimeLocal(), TIME_DATE | TIME_SECONDS);
  //return calculated time to the main function
  //return TimeWithSeconds;

//}

///+++++++++++++++++++++++++++++++++++++++The end of the  of the custom Timer module++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///




///+++++++++++++++++++++++++++++++++++++++The begining of the  of the custom Timer module+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///
string GetTime() {

  //create a chart output for time with seconds;

  string TimeWithSeconds;

  //calculate time with seconds for local time
  TimeWithSeconds = TimeToString(TIME_SECONDS);
  //return calculated time to the main function
  return TimeWithSeconds;

}

///+++++++++++++++++++++++++++++++++++++++The end of the  of the custom Timer module++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///



//+++++++++++++++++++++++++++++++++++++The begining of the checkfornew candle function definition+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

string CheckForNewCandle(int CandleNumber) {

  //we create a static int vairable for the last candle number 
  static int LastCandleNumber;
  //we create a string int vairable for the candle number

  string IsNewCandle = "no new candle";
  //we create a string for the diffrence 
  if (CandleNumber > LastCandleNumber) {
    //we check if we have a diffrence
    IsNewCandle = "YES, A NEW CANDLE APPEARED!";

    //we set the curent value for the next time
    LastCandleNumber = CandleNumber;
  }

  //we return the result to the main function
  return IsNewCandle;
}
//+++++++++++++++++++++++++++++++++++++The END of the checkfornew candle function definition+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++///

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++BEGINING OF THE CLOSE ALL BUY POSITION++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
void CloseAllBuyPositions()

{
  //count down untill there are no Positions Right
  for (int i = PositionsTotal() - 1; i >= 0; i--) // go through all positions
  {
    //Get the ticket number for the current position
    int ticket = PositionGetTicket(i);

    //Get the Position direction 
    int PositionDiretion = PositionGetInteger(POSITION_TYPE);

    if (PositionDiretion == POSITION_TYPE_BUY)
      //close the current sell position
      trade.PositionClose(ticket);

  } //end for loop
} //end the function

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++END OF THE CLOSE ALL BUY POSITION+++++++++++++++++++++++++++//

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
  //---
  
  
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++The algorithm+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

//when new canldle apear
//wait for 11 seconds
//check idf the candle is positive or negative 
//if the candle is positive  then take a BUY.
//wait for the 21 sec and close the buy.
//if the candle is negative then check for_the_new_candle_apeared()


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++The algorithm+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
//the procedure
//ontick
//count the 11 secs
//check the close proce of the current candle if its is lower or higher than the initial candle price
//if it is higher == buy wait for 
//if it is lower Do noting
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Parameters++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
//delay == 11 sec
//take trade == 21 sec
//close trade == 20 sec
  string myTime;
  //call custome function Gettime to calculate time
  myTime = GetTime();
  //get the state of the candle 
  string candle_state;
  candle_state = Detect_The_current_candle_state();

  //Create a chart output for the time
  //Comment(myTime);

  //We calculate the current candle number
  int CandleNumber = Bars(_Symbol, PERIOD_M1);

  //we create a string vairable
  string NewCandleAppeared = "";

  //we call a user defined function
  NewCandleAppeared = CheckForNewCandle(CandleNumber);

  //we create a chart output
  Comment("bar on chart: ", CandleNumber, "\n", "new candle appeared: ", NewCandleAppeared, "\n", myTime,"\n",candle_state);

}
//+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+