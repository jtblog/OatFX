import socketio
import engineio
import fxcmpy

T = 'm1' #Period
sz = 1000 #Size

class fx(fxcmpy.fxcmpy):
    pass

class SharedObjects:

    def __init__(self, fx):
        self.con = fx

    def set_connection(self, fx):
        self.con = fx

    def get_connection(self):
        return self.con

    def print_account(self):
        print(self.con.get_accounts())

    def close(self):
        self.con.close()
    pass

obj = SharedObjects(None)