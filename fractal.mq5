//+------------------------------------------------------------------+
//|                                                      fractal.mq5 |
//|                                                    Sir_Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir_Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include<Trade\Trade.mqh>
CTrade trade;
//---https://www.youtube.com/watch?v=1FFAf14-Cog

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
    // We calculate the Ask price
    //double Ask = NormalizeDouble (SymbolInfoDouble(_Symbol,SYMBOL_ASK) , _Digits);
 
    //We calculate the Bid price
   // double Bid=NormalizeDouble (SymbolInfoDouble (_Symbol,SYMBOL_BID), _Digits);
      //we create a string for the signal
    string signal= "";
    //create a price array
   MqlRates PriceArray[];
   
   //test buy
   trade.Buy(0.2,Symbol());
   //sort the price array with data for 3 candles
   ArraySetAsSeries(PriceArray, true);
   //will fill the array from the current candle downwards
   int Data = CopyRates(_Symbol,_Period,0,3,PriceArray);
   
   //create an fractal array
   double UpperFractalsArray[],LowerFractalsArray[];
   //Define EA, current candles, 3 candles, save the result
    int FractalDefinition = iFractals(_Symbol,_Period);
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
    if(LowerFractalsValue<PriceArray[0].low)
    {
        signal= "buy";
    }

    //sell signal
    //if its going down 
    if (LowerFractalsValue!=0)
    if(LowerFractalsValue<PriceArray[0].high)
    {
        signal= "sell";
    }
  

  //sell 10 Microlot

 // if(signal == "buy" && PositionsTotal()<1)
  //trade.Sell(0.10,NULL,Bid,(Bid-200* _Period),(Bid+150*_Point),NULL);
  //Open 20 microlot size sell positions 
   // trade.Buy(0.2,Symbol());
 
  //Buy 10 Microlot

  if(signal == "buy" && PositionsTotal()<1)
  //trade.Buy(0.10,NULL,Ask,(Ask-200* _Period),(Ask+150*_Point),NULL);
   trade.Buy(0.20);
    //Chart output
    Comment (
        "The signal is:",signal, "\n",
        "Upper Fractals value:",UpperFractalsValue,"\n",
        "Lower Fractals value:", LowerFractalsValue,"\n"

    );

  }
//+------------------------------------------------------------------+
