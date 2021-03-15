from django.db import models
import json

class pair(models.Model):
    _open = models.CharField()
    _high = models.CharField()
    _low = models.CharField()
    _close = models.CharField()

    @property
    def open(self):
        return json.loads(self._open)
    @open.setter
    def open(self, value):
        self._open = json.dumps(value)

    @property
    def high(self):
        return json.loads(self._high)
    @high.setter
    def high(self, value):
        self._high = json.dumps(value)
    
    @property
    def low(self):
        return json.loads(self._low)
    @low.setter
    def low(self, value):
        self._low = json.dumps(value)
    
    @property
    def close(self):
        return json.loads(self._close)
    @close.setter
    def close(self, value):
        self._close = json.dumps(value)
    pass