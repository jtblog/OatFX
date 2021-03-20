import socketio
import engineio
import fxcmpy
import pandas
from datetime import datetime, timedelta
#from collections import deque
import schedule
import time
from background_task import background

from trader.models import pair


class SharedObjects:

    T = 'm1' #Period
    sz = 1000 #Size
    prices = pandas.DataFrame()
    instruments = ['EUR/USD', 'USD/JPY', 'GBP/USD', 'USD/CHF', 'USD/CAD', 'AUD/USD', 'NZD/USD']

    class fx(fxcmpy.fxcmpy):
        pass

    def __init__(self, fx=None):
        self.con = fx

    @background(schedule=60)
    def test():
        print(pandas.Timestamp.now())
        #self.test()


    def set_connection(self, fx):
        self.prices = pandas.DataFrame()
        self.con = fx
        #self.test()
        print(pandas.Timestamp.now())
        '''schedule.every(1).minutes.do(self.minutely_task)
        while True:
            schedule.run_pending()
            time.sleep(1)'''
        #self.get_instruments()

    def get_connection(self):
        try:
            if self.con.is_connected():
                return self.con
            else:
                return None
        except AttributeError:
            return None

    def get_instruments(self):
        '''self.instruments = self.con.get_instruments()
        while ("" in self.instruments):
            self.instruments.remove("")'''
        for sbl in self.instruments:
            data = self.con.get_candles(sbl, period='m1', number=1000)
            if self.dataframe_is_empty(data) == False:
                # Note Last timestamp in database, 
                # t0 lags by one hour 
                # So therefore instant current time, 
                # t1 is pandas.Timestamp.now() - timedelta(hours=1)
                t0 = data.axes[0].tolist()[len(data.axes[0].tolist())-1]
                t1 = pandas.Timestamp.now() - timedelta(hours=1)
                if(t1 - t0).seconds / 60 <= 1:
                    cl = data.columns.to_list()
                    cl.remove('tickqty')
                    data.insert(0, 'Close', (data['askclose'] + data['bidclose']) / 2)
                    data.insert(1, 'Open', (data['askopen'] + data['bidopen']) / 2)
                    data.insert(2, 'High', (data['askhigh'] + data['bidhigh']) / 2)
                    data.insert(3, 'Low', (data['asklow'] + data['bidlow']) / 2)
                    data.drop(cl, inplace= True, axis=1)
                    pair.objects.create(symbol = sbl, data=data.to_json(orient='split'))
                    #pair.putframe(sbl, data)
                    self.con.subscribe_market_data(sbl, (self.update,))
                else:
                    pass
            else:
                pass
    
    def update(self, dict_data, dataframe):
        try:
            pr = pair.objects.get(symbol=dict_data['Symbol'])
            p =  pandas.read_json(pr.data, orient='split')
            t0 = p.index[len(p.index)-2]
            t1 = p.index[len(p.index)-1]
            t2 = pandas.to_datetime(dict_data['Updated'], unit='ms')
            #rates = dict_data['Rates']

            if(t2 - t0).seconds / 60 >= 1 and (t2 - t0).seconds / 60 < 2:
                dtf = dataframe.copy()
                dtf.drop(dtf.head(len(dtf.axes[0].tolist())-1).index, inplace=True)
                dtf.insert(0, 'Close', (dtf['Bid'] + dtf['Ask']) / 2)
                dtf.drop(['Bid', 'Ask'], inplace= True, axis=1)
                dtf.insert(3, 'tickqty', 0)
                dtf.insert(1, 'Open', float(p.at[p.index[-2] , 'Close']))

                if pandas.Timestamp(t1).second != 0:
                    p.drop(p.tail(1).index, inplace=True)
                    newdtf = pandas.concat([p, dtf])
                else:
                    p.drop(p.head(1).index, inplace=True)
                    newdtf = pandas.concat([p, dtf])
                    pass
                #pr.putframe(dict_data['Symbol'], newdtf)
                pair.objects.filter(symbol=dict_data['Symbol']).update(data=newdtf.to_json(orient='split'))
                #pr.data = newdtf.to_json(orient='split')
                #pr.save()

            elif (t2 - t0).seconds / 60 >= 2 and (t2 - t0).seconds / 60 < 3 :
                data = self.con.get_candles(dict_data['Symbol'], period='m1', number=1)
                if self.dataframe_is_empty(data) == False:
                    cl = data.columns.to_list()
                    cl.remove('tickqty')
                    data.insert(0, 'Close', (data['askclose'] + data['bidclose']) / 2)
                    data.insert(1, 'Open', (data['askopen'] + data['bidopen']) / 2)
                    data.insert(2, 'High', (data['askhigh'] + data['bidhigh']) / 2)
                    data.insert(3, 'Low', (data['asklow'] + data['bidlow']) / 2)
                    data.drop(cl, inplace= True, axis=1)
                    p.drop(p.tail(1).index, inplace=True)
                    p = pandas.concat([p, data])

                    p.drop(p.head(1).index, inplace=True)
                    dtf = dataframe.copy()
                    dtf.drop(dtf.head(len(dtf.axes[0].tolist())-1).index, inplace=True)
                    dtf.insert(0, 'Close', (dtf['Bid'] + dtf['Ask']) / 2)
                    dtf.drop(['Bid', 'Ask'], inplace= True, axis=1)
                    dtf.insert(3, 'tickqty', 0)
                    dtf.insert(1, 'Open', float(p.at[p.index[-2] , 'Close']))
                    newdtf = pandas.concat([p, dtf])
                    #pr.putframe(dict_data['Symbol'], newdtf)
                    pair.objects.filter(symbol=dict_data['Symbol']).update(data=newdtf.to_json(orient='split'))
                    #pr.data = newdtf.to_json(orient='split')
                    #pr.save()
            else:
                self.con.unsubscribe_market_data(dict_data['Symbol'])
                pass
        except pair.DoesNotExist:
            self.con.unsubscribe_market_data(dict_data['Symbol'])
            pass
        pass

    def minutely_task(self):
        return pandas.Timestamp.now()
        pass
    

    def cleardb(self):
        pair.objects.all().delete()

    def dataframe_is_empty(self, dataframe):
        if dataframe.empty == True:
            return True
        if dataframe.shape[0] == 0:
            return True
        if len(dataframe.index.values) < 2:
            return True
        return False

    def close(self):
        self.con.close()
    pass

obj = SharedObjects(None)