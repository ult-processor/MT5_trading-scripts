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
// We calculate the Ask price
double RSIAsk=NormalizeDouble (SymbolInfoDouble(_Symbol,SYMBOL_ASK) , _Digits);

// We calculate the Bid price
double RSIBid=NormalizeDouble (SymbolInfoDouble (_Symbol,SYMBOL_BID), _Digits);

// create a string for the signal
string RSIsignal="";

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
RSIsignal = "BUY";
trade.Buy(0.20);}



if(myRSIValueM1>50 && myRSIValueM5>50){
Comment("sell M1 and M5");
RSIsignal = "SELL";
trade.Sell(0.20);}



//return signal;
 }