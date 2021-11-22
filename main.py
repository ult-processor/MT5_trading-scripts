import datetime
import backtrader as bt

# Create a subclass of Strategy to define the indicators and logic

class SmaCross(bt.Strategy):
    # list of parameters which are configurable for the strategy
    params = dict(
        pfast=10,  # period for the fast moving average
        pslow=30   # period for the slow moving average
    )

    def __init__(self):
        sma1 = bt.ind.SMMA(period=8)
        self.sma = bt.indicators.MovingAverageSimple(self.datas[0], period=8)
        # sma1 = bt.ind.SMMA(period=self.p.pfast)  # fast moving average
        # sma2 = bt.ind.SMA(period=self.p.pslow)  # slow moving average
        # self.crossover = bt.ind.CrossOver(sma1, sma2)  # crossover signal

    def next(self):
        # print(self.data.close[0])
        print(self.sma[0])

        # if not self.position:  # not in the market
        #     if self.crossover > 0:  # if fast crosses slow to the upside
        #         self.buy()  # enter long

        # elif self.crossover < 0:  # in the market & cross to the downside
        #     self.close()  # close long position


cerebro = bt.Cerebro()  # create a "Cerebro" engine instance

# Create a data feed
datapath = 'orcl-1995-2014.txt'

# Create a Data Feed
data = bt.feeds.YahooFinanceCSVData(
    dataname=datapath,        
    fromdate=datetime.datetime(2000, 1, 1),
    todate=datetime.datetime(2000, 12, 31),
    reverse=False)

cerebro.resampledata(
        data, timeframe=bt.TimeFrame.Days, compression=5)

# cerebro.adddata(data)  # Add the data feed

cerebro.addstrategy(SmaCross)  # Add the trading strategy
cerebro.run()  # run it all
cerebro.plot()  # and plot it with a single command