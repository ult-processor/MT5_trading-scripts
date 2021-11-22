//+------------------------------------------------------------------+
//|                                                Sell_position.mq5 |
//|                                                    Sir Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+




//+------------------------------------------------------------------+
//|                                    1close all sell positions.mq5 |
//|                                                    Sir Processor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sir Processor"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
//---the begining of the close all long positions
    //Get the Ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK))

    //if we have less than 10 positions 
    if (PositionsTotal() < 3)
      //Open 20 microlot size
      trade.Sell(0.20, NULL, Ask, (Ask - 1000 * _Point), (), NULL);
    //if we have exactly 10 positions
    if (PositionsTotal() == 3)
      //close all open positions
      Void CloseAllBuyPositions() {
        //count down untill there are no position left 
        for (int i = PositionsTotal() - 1; i >= 0; i--) // go through all positions

        {
          int ticket = PositionGetTicket(i);
          //Get the positions
          int PositionDirection = PositionGetDouble(POSITION_TYPE);
          //if it is a buy position
          if (PositionDirection == POSITION_TYPE_BUY)
            //close the current position
             trade.PositionClose(ticket);
   
  }
//+------------------------------------------------------------------+
