import datetime  
import os.path  
import sys  


import backtrader as bt


class MyStochastic1(bt.Indicator):
    
    lines = ('k', 'd', )  #Lines object to display on the plot
    params = (
        ('k_period', 14), #Specify parameters with tuples of tuples
        ('d_period', 3),  #Comma at the end of the tuple(、)Put in
    )
    
    #abridgement
    #plotinfo = dict()

    def __init__(self):
        #To be exact, self.datas[0]Can be omitted
        # self.params.k_omit period and self.p.k_period 
        highest = bt.ind.Highest(self.data, period=self.p.k_period)
        lowest = bt.ind.Lowest(self.data, period=self.p.k_period)        
       
        self.lines.k = k = (self.data - lowest) / (highest - lowest)    
        self.lines.d = bt.ind.SMA(k, period=self.p.d_period)

    def next(self):
        print(self.data[0])
        

class TestStrategy(bt.Strategy):
    def __init__(self):
        #The instance name myind1 can be any name
        self.myind1 = MyStochastic1(self.data)    
        
        
if __name__ == '__main__':
    cerebro = bt.Cerebro()
    cerebro.addstrategy(TestStrategy)

    datapath = 'orcl-1995-2014.txt'

    # Create a Data Feed
    data = bt.feeds.YahooFinanceCSVData(
        dataname=datapath,        
        fromdate=datetime.datetime(2000, 1, 1),
        todate=datetime.datetime(2000, 12, 31),
        reverse=False)

    cerebro.adddata(data)
    cerebro.run(stdstats=False)
    cerebro.plot(style='candle')