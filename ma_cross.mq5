//+------------------------------------------------------------------+
//|                                                     ma_cross.mq5 |
//|                                                    Sir_Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir_Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"
void OnTick()
{

   // create an array for several prices
   double myMovingAverageArray1[] ,myMovingAverageArray2[];
 
   string MAsignal="";
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
 }