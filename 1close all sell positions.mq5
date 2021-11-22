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

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
//https://www.youtube.com/watch?v=uuIOwqKR7-I
#include <Trade\Trade.mqh>
CTrade trade;
void OnTick()
  {

//

    //if we have less than 3 positions 
    if (PositionsTotal() < 4)
     //Open 20 microlot size sell positions 
     trade.Sell(0.2,Symbol());
    //if we have exactly 3
      if (PositionsTotal() == 4)
       CloseAllSellPositions();

   
  }
  
  void CloseAllSellPositions()
  
  {
  //count down untill there are no Positions left
  for (int i =PositionsTotal()-1; i>=0; i--) // go through all positions
  {
  //Get the ticket number for the current position
  ulong ticket=PositionGetTicket(i);
  
  //Get the Position direction 
  long PositionDiretion=PositionGetInteger(POSITION_TYPE);
  //--- receive position ID for further work
  // ulong PositionDiretion=PositionGetInteger(POSITION_TYPE);
  
  //if it is a sell position
  //if (PositionDiretion==POSITION_TYPE);
  //if its is a sell Position
  if (PositionDiretion==POSITION_TYPE_SELL)
  
  //close the current sell position
  trade.PositionClose(ticket);
  }
  }
  
//+------------------------------------------------------------------+
