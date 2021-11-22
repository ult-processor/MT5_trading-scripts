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

    //if we have less than 3 positions 
    if (PositionsTotal() < 5)
     trade.Buy(0.2,Symbol());
     CloseAllBuyPositions();

   
  }
  
  void CloseAllBuyPositions()
  
  {
  //count down untill there are no Positions Right
  for (int i =PositionsTotal()-1; i>=0; i--) // go through all positions
  {
  //Get the ticket number for the current position
  int ticket=PositionGetTicket(i);
  
  //Get the Position direction 
  int PositionDiretion=PositionGetInteger(POSITION_TYPE);

  if (PositionDiretion==POSITION_TYPE_BUY)
  //close the current sell position
  trade.PositionClose(ticket);
  
  
  }//end for loop
  }//end the function
  
//+------------------------------------------------------------------+
