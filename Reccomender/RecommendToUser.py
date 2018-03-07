"""
Organize the beers liked for a user
"""

from __future__ import print_function

import argparse
import logging
import os
import time
import numpy
import pandas
import csv
from scipy.sparse import coo_matrix

from implicit.als import AlternatingLeastSquares
from implicit.nearest_neighbours import (BM25Recommender, CosineRecommender,
                                         TFIDFRecommender, bm25_weight)

def choiceBeers(userId, path):
    """ Reads in the dataset """
    recommends = open(path + "testRecommendation.csv", "r")
    allFile = csv.reader(recommends, delimiter=",")
    idBeers = [] # list of beers-ID
    count = 0
    for row in allFile:
        if(count != 0):
            if(row[0] == userId and row[2] == '1'):
                idBeers.append(row[1])
        count+=1
    recommends.close()

    names = open(path + "testBeer.csv", "r")
    allFile2 = csv.reader(names, delimiter=",")
    namedBeers = [] # list of beers-names
    count = 0
    for row in allFile2:
        if(count != 0):
            if(row[0] in idBeers):
                namedBeers.append(row[1])
        count+=1
    names.close()

    similars = open(path+"result.csv", "r")
    allFile3 = csv.reader(similars, delimiter=",")
    result = []
    for row in allFile3:
        for i in range(0, len(namedBeers)):
            if(row[0] == namedBeers[i] and float(row[2])>=0.6):
                result.append(row[1])

    result = list(set(result))
    return result



if __name__ == "__main__":
    path = "/home/ale96/Documents/beerer/Beerer/.idea/src/dataset/"
    print(choiceBeers("4", path))