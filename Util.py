
import json
import os

class Util:

    @staticmethod
    def getConfig(attrName):
        dir_path = os.path.dirname(os.path.realpath(__file__))
        with open(dir_path+'/config.json') as json_data_file:
            data = json.load(json_data_file)
        return data[attrName]
