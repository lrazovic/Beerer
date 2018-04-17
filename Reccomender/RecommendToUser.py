"""
Organize the beers liked for a user
"""

from __future__ import print_function

import argparse
import logging
import os
import time
import numpy as np
import pandas as pd
import csv
from scipy.sparse import coo_matrix

from implicit.als import AlternatingLeastSquares
from implicit.bpr import BayesianPersonalizedRanking
from implicit.nearest_neighbours import (BM25Recommender, CosineRecommender,
                                         TFIDFRecommender, bm25_weight)


def choiceBeers(userId, path):

    # Get beerID for given userId
    recommends = pd.read_csv(path + "testRecommendation.csv")
    # print((recommends["USR"]) == userId) 
    # data_filtered = recommends[userId]
    idBeers = []  # list of beers-ID


    # Use Panda
    names = open(path + "testBeer.csv", "r")
    allFile2 = csv.reader(names, delimiter=",")
    namedBeers = []  # list of beers-names
    count = 0

    for row in allFile2:
        if(count != 0):
            if(row[0] in idBeers):
                namedBeers.append(row[1])
        count += 1
    names.close()

    # Use Panda
    similars = open(path+"result.csv", "r")
    allFile3 = csv.reader(similars, delimiter=",")
    result = []

    for row in allFile3:
        for i in range(0, len(namedBeers)):
            if(row[0] == namedBeers[i] and float(row[2]) >= 0.6):
                result.append(row[1])

    result = list(set(result))
    return result


if __name__ == "__main__":
    # Change Path
    path = "/Users/lrazovic/Projects/Beerer/Reccomender/dataset/"
    print(choiceBeers("4", path))
