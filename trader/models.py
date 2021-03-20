from django.db import models
#from django.contrib.postgres.fields import ArrayField, JSONField
import json
import pandas

# Create your models here.
class pair(models.Model):
    symbol = models.CharField(max_length = 200)
    data = models.TextField(null=True)
    #data = JSONField()

    '''
    @property
    def data(self):
        return pandas.read_json(self.data, orient='split')

    @data.setter
    def data(self, value):
        self._data = value.to_json(orient='split')
    '''
