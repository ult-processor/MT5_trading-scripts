//+------------------------------------------------------------------+
//|                                                        fuzzy.mq5 |
//|                                                    Sir_Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir_Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
CTrade trade;
void OnTick()
  {
//---
//we create a string for the signal
//string signal= "";

//we create a string for the MAsignal
string MAsignal= "";


//we create a string for the signal
string RSIsignal= "";


//we create a string for the signal
string Fractal_signal= "";


//we create a string for the signal
string ICHsignal= "";


//we create a string for the signal
//string ICHsignal= "";

//we create a string for the Fractal_signal  on 5min
string Fractal_tp= "";


//we create a string for the Fractal_signal  on 5min
string ICHsignal_tp= "";

//we create a string for the signal
//string ICHsignal= "";


//we create a string for the signal
//string ICHsignal= "";

////+-------------------------THE BEGINING OF THE ICHIMOKU EA--------------------------------------------------------------+

// Create an Array for prices
MqlRates PriceInformation[];

// Sort the array from the current candle downwards
ArraySetAsSeries (PriceInformation, true);
// We calculate the Ask price
double Ask=NormalizeDouble (SymbolInfoDouble(_Symbol,SYMBOL_ASK) , _Digits);

// We calculate the Bid price
double Bid=NormalizeDouble (SymbolInfoDouble (_Symbol,SYMBOL_BID), _Digits);

 //trade.Buy(0.20);

// Copy price data into the array
//int Data = CopyRates(Symbol(), Period(),0,3,PriceInformation);
int Data = CopyRates(Symbol(),PERIOD_M1)
// Create an array for the price data
double TenkansenArray[];

// Define the EA
int IchimokuDefinition =iIchimoku(_Symbol, PERIOD_M1, 9,26,52);

int IchimokuDefinition5 =iIchimoku(_Symbol, PERIOD_M5, 9,26,52);

// Sort the prices from the current candle downwards
ArraySetAsSeries (TenkansenArray, true);


// Defined EA, one line, current candle,for 3 candles,
CopyBuffer (IchimokuDefinition, 0,0,3,TenkansenArray);

// Calculate the value for the current candle
double TenkansenValue=TenkansenArray[0];
// PrintFormat("Ichmoku said",TenkansenValue);

// Tf value is above
if (TenkansenValue>PriceInformation[1].close)
ICHsignal="sell";

// Tf value is below
if (TenkansenValue<PriceInformation[1].close)
ICHsignal="buy";

// sell 20 Microlot
if (ICHsignal =="sell" && PositionsTotal()<1)
trade.Sell(0.20);
ICHsignal = "SELL";

//  
// bay 20 Microlot
if (ICHsignal =="buy" && PositionsTotal ()<1)
//trade.Buy(0.20);
ICHsignal = "BUY";
//buy
//trade.Buy(qty,Symbol());
//close

//trade.PositionClose(Symbol());


//+-------------------------THE END OF THE ICHIMOKU EA--------------------------------------------------------------+



////+-------------------------THE BEGINING OF THE fRACTAL EA--------------------------------------------------------------+



// We calculate the Ask price
    double fractalAsk = NormalizeDouble (SymbolInfoDouble(_Symbol,SYMBOL_ASK) , _Digits);
 
    //We calculate the Bid price
    double fractalBid=NormalizeDouble (SymbolInfoDouble (_Symbol,SYMBOL_BID), _Digits);
      //we create a string for the signal
    //string signal= "";
    //create a price array
   MqlRates PriceArray[];
   //sort the price array with data for 3 candles
   ArraySetAsSeries(PriceArray, true);
   //will fill the array from the current candle downwards
   int FractalData = CopyRates(_Symbol,PERIOD_M5,0,3,PriceArray);
   
   //create an fractal array
   double UpperFractalsArray[],LowerFractalsArray[];
   //Define EA, current candles, 3 candles, save the result
    int FractalDefinition = iFractals(_Symbol,PERIOD_M5);
   //sort the array from the current candles downwards 
   ArraySetAsSeries(UpperFractalsArray, true);
   ArraySetAsSeries(LowerFractalsArray,true);

   //Define EA current buffer, current candle, 3 candle save in Array
   CopyBuffer(FractalDefinition, UPPER_LINE,1,3, UpperFractalsArray);
   CopyBuffer(FractalDefinition,LOWER_LINE,1,3,LowerFractalsArray);

   //calculate the upper fractal value
   double UpperFractalsValue = UpperFractalsArray[1];
   double LowerFractalsValue = LowerFractalsArray[1];
    //reset if value is empty
    if (UpperFractalsValue == EMPTY_VALUE)
    UpperFractalsValue=0;

    //reset if the Value is empty
    if(LowerFractalsValue==EMPTY_VALUE)
    LowerFractalsValue=0;

    //if its going up 
    if (LowerFractalsValue!=0)
    if(LowerFractalsValue<PriceArray[1].low)
    {
        Fractal_signal= "BUY";
    }

    //sell signal
    //if its going down 
    if (LowerFractalsValue!=0)
    if(LowerFractalsValue<PriceArray[1].high)
    {
        Fractal_signal= "SELL";
    }
  

  //sell 20 Microlot

  if(Fractal_signal == "BUY" && PositionsTotal()<1)
 // trade.Sell(0.20,NULL,fractalBid,(fractalBid-200* _Period),(fractalBid+150*_Point),NULL);
   trade.Sell(0.20);
  //Buy 20 Microlot

  if(Fractal_signal == "BUY" && PositionsTotal()<1)
  trade.Buy(0.20,NULL,Ask,(fractalAsk-200* _Period),(fractalAsk+150*_Point),NULL);

    //Chart output
    Comment (
        "The signal is:",Fractal_signal, "\n",
        "Upper Fractals value:",UpperFractalsValue,"\n",
        "Lower Fractals value:", LowerFractalsValue,"\n"

    );

////+----------------------------------THE END OF THE fRACTAL EA--------------------------------------------------------------+



////+----------------------------------THE Begining of MA EA--------------------------------------------------------------+

// create an array for several prices
   double myMovingAverageArray1[] ,myMovingAverageArray2[];
 
   //string MAsignal="";
   // define the properties of the moving average1
   int movingaverageDefinition1 = iMA(_Symbol,PERIOD_M1,12,0,MODE_EMA,PRICE_CLOSE);

   int movingaverageDefinition2 = iMA(_Symbol,PERIOD_M1,20,0,MODE_SMA,PRICE_CLOSE);
   //int movingaverageDefinition5 = iMA(_Symbol,PERIOD_M5,12,0,MODE_SMA,PRICE_CLOSE);    
   // define the properties of the moving average2
   //int movingaverageDefinition2 = iMA (Symbol, PERIOD_M1,20,0,MODE_EMA, PRICE CLOSE);

   //int movingaverageDefinition2 = iMA(_Symbol, PERIOD_M1,20,0,MODE_SMA, PRICE_CLOSE);

  // int movingaverageDefinition3 = iMA (_Symbol, _Period,200,0,MODE_SMA, PRICE_CLOSE);

   //int movingaverageDefinition2 = ima ( Symbol, Period, 50,0,MODE_SMA, PRICE_CLOSE);

 
   // sort the price array1 from the current candle downwards
   ArraySetAsSeries(myMovingAverageArray1, true);

   // sort the price array2 from the current candle downwards
   ArraySetAsSeries (myMovingAverageArray2, true);
   
   
   // sort the price array3 from the current candle downwards
   //ArraySetAsSeries (myMovingAverageArray3, true);
   
   //Define MA1, oneline current candle, 3 candles, store result
   //CopyBuffer(movingaverageDefinition1,0,0,3,myMovingAverageArray2,myMovingAverageArray3);
   CopyBuffer(movingaverageDefinition1,0,0,3,myMovingAverageArray1);
   
    //Define MA2, oneline current candle, 3 candles, store result
   CopyBuffer(movingaverageDefinition2,0,0,3,myMovingAverageArray2);
   
   if (
      //check if the 12 candle EA is above the 20 candle EA
      (myMovingAverageArray1[0]>myMovingAverageArray2[0])
      && (myMovingAverageArray1[1]>myMovingAverageArray2[1])
   )
   
   {
   MAsignal = "SELL";
   Comment("SELL");
   }
   
   if (
      //check if the 20 candle EA is above the 12 candle EA
      (myMovingAverageArray1[0]>myMovingAverageArray2[0])
      && (myMovingAverageArray1[1]>myMovingAverageArray2[1])
      )
      {
      MAsignal = "BUY";
      Comment("BUY");
      }


////+----------------------------------THE END OF THE MA EA--------------------------------------------------------------+



////+----------------------------------THE BEGINING OF THE RSI EA--------------------------------------------------------------+



// We calculate the Ask price
double RSIAsk=NormalizeDouble (SymbolInfoDouble(_Symbol,SYMBOL_ASK) , _Digits);

// We calculate the Bid price
double RSIBid=NormalizeDouble (SymbolInfoDouble (_Symbol,SYMBOL_BID), _Digits);

// create a string for the signal
//string RSIsignal="";

// create an array for the price on 1min data
double myRSIArrayM1[];
//double myRSIArrayM5[];


// create an array for the price on 5min data

double myRSIArrayM5[];

// define the properties for the RSI
//define rsi on 5min
int myRSIDefinition5min = iRSI(_Symbol, PERIOD_M5,14,PRICE_CLOSE);
int myRSIDefinition1min = iRSI(_Symbol, PERIOD_M1,14,PRICE_CLOSE);

//int myICHmochudefinition5min = iIchimoku(_Symbol,PERIOD_M5, 9,9,52);
//Print(myICHmochudefinition5min);
//int myRSIDefinition = iRSI (_Symbol, _Period,14,PRICE_CLOSE);

// Defined EA,from current candle,for 3 candles, save in array
CopyBuffer (myRSIDefinition1min,0,0,3,myRSIArrayM1) ;


CopyBuffer (myRSIDefinition5min,0,0,3,myRSIArrayM5) ;
// calculate the current RSI value for M1
double myRSIValueM1 = NormalizeDouble (myRSIArrayM1 [0] ,2);

// calculate the current RSI value for M5
double myRSIValueM5 = NormalizeDouble (myRSIArrayM5 [0] ,2);

if (myRSIValueM1<50 && myRSIValueM5<50)
{
Comment("buy M1 and M5");
RSIsignal = "BUY";}


if(myRSIValueM1>50 && myRSIValueM5>50){
Comment("sell M1 and M5");
RSIsignal = "SELL";}
//return signal;

////+----------------------------------THE END iiiiiiiiiiiilOF THE RSI EA--------------------------------------------------------------+

}

//+------------------------------------------------------------------+
