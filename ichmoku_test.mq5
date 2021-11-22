//+------------------------------------------------------------------+
//|                                                 ichmoku_test.mq5 |
//|                                                    Sir Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"
void OnTick()
  {
//---

string ICHsignal ="";

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
   
  }
//+------------------------------------------------------------------+
