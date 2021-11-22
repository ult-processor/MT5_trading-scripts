//+------------------------------------------------------------------+
//|                                           ichimoku_oscilator.mq5 |
//|                                                    Sir_Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir_Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
 #include  <Trade\Trade.mqh>

   //Create an instance of CTrade
   CTrade trade;

void OnTick()
   {
   //We calculate the Ask price
   double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   
   //We calculate the Bid price
   double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   
   //We create an array for the prices
   MqlRates PriceInfo[];
   
   //Sort the price array from the current candle downwards
   ArraySetAsSeries(PriceInfo,true);
   
   //We fill the array with price data
   int PriceData =CopyRates(_Symbol,_Period,0,3,PriceInfo);
   
   //Create a string for the signal
   string signal="";
   
   //Create 2 Arrays for Ichimoku and Stochastic Oscillator
   double IchimokuArray[],StochasticArray[];
      
   //we define Ichimoku, Stochastic Oscillator
   int IchimokuDefinition = iIchimoku(_Symbol,_Period,9,9,52);
   int StochasticDefinition = iStochastic(_Symbol,_Period,1,1,1,MODE_SMA,STO_LOWHIGH);
   
   //Sort the price array from the current candle downwards
   ArraySetAsSeries(IchimokuArray,true);
   ArraySetAsSeries(StochasticArray,true);
   
   //we fill the array with price data
   //Defined EA, one line, current candle for 3 candles, store in array
   CopyBuffer(IchimokuDefinition,0,0,3,IchimokuArray);
   CopyBuffer(StochasticDefinition,0,0,3,StochasticArray);
   
   //Calculate Ichimoku and Stochastic Value of the current candle
   double IchimokuValue=NormalizeDouble(IchimokuArray[0],2);
   double StochasticValue=NormalizeDouble(StochasticArray[0],2);
   
    if (IchimokuValue == 20)
    Comment("The IchimokuValue is now: ",IchimokuValue);
    
    if (StochasticValue == 20)
    Comment("The StochasticValue is now: ",StochasticValue);
    trade.Buy(50,Symbol());
    //trade.Buy(0.20,NULL,Ask,(Ask-5000 *_Point),NULL);
     //buy
     
   //PrintFormat("Ichmoku said",IchimokuValue);
   //PrintFormat("Stochastic said",StochasticValue);
   //--- Output values in three lines
   //Comment(StringFormat("Ichmoku said",IchimokuValue));
   //--- Output values in three lines
   //Comment(StringFormat("Stochastic said",StochasticValue));

   
   //Buy signal
   //if Ichimoku is above Stochastic level 14
//   if (IchimokuArray[0]==StochasticArray[0]>14)
   
   //and Ichimoku is below Stochastic level 16
  // if (IchimokuArray[0]==StochasticValue[0]<16)
   
   //that means Ichimoku line has touched Stochastic level 15
    // {  signal="buy"; }
     
   //Buy 20 microlot
   //if (signal =="buy" && PositionsTotal()<1)
   //trade.Buy(0.20,NULL,Ask,(Ask-5000 *_Point),NULL);
   
   //chat output
   //Comment("The signal is now: ",signal);
   
  }