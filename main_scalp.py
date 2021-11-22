import backtrader as bt
import datetime


class KeltnerChannel(bt.Indicator):
    lines = ('mid', 'upper', 'lower')
    params = dict(
                ema=20,
                atr=2
                )

    plotinfo = dict(subplot=False)  # plot along with data
    plotlines = dict(
        mid=dict(ls='--'),  # dashed line
        upper=dict(_samecolor=True),  # use same color as prev line (mid)
        lower=dict(_samecolor=True),  # use same color as prev line (upper)
    )

    def __init__(self):
        self.l.mid = bt.ind.EMA(period=self.p.ema)
        self.l.upper = self.l.mid + bt.ind.ATR(period=self.p.ema) * self.p.atr
        self.l.lower = self.l.mid - bt.ind.ATR(period=self.p.ema) * self.p.atr




class Strategy(bt.Strategy):

    def __init__(self):
        self.keltner = KeltnerChannel()

    def next(self):
        if self.keltner.l.lower[0] > self.data[0]:
            self.buy()
        elif self.keltner.l.upper[0] < self.data[0]:
            self.sell()


if __name__ == '__main__':
    # Create cerebro instance
    cerebro = bt.Cerebro()

    # Create a Data Feed
    data = bt.feeds.GenericCSVData(
        dataname='test.csv',
        # fromdate=datetime.datetime(2019, 1, 1),
        # todate=datetime.datetime(2019, 12, 31),
        nullvalue=0.0,
        # dtformat=('%Y-%m-%d'),
        dtformat=lambda x: datetime.datetime.utcfromtimestamp(float(x) / 1000.0),
        datetime=0,
        open = 1,
        close = 2,
        high = 3, 
        low = 3,
        volume =5, 
        openinterest=-1,
        reverse=False)

    # Add the Data Feed to Cerebro
    cerebro.adddata(data)

    print('Starting Portfolio Value: %.2f' % cerebro.broker.getvalue())

    # Add Strategy
    cerebro.addstrategy(Strategy)
    results = cerebro.run(stdstats=False)

    print('Final Portfolio Value: %.2f' % cerebro.broker.getvalue())

    cerebro.plot()