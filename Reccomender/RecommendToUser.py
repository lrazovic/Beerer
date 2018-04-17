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
    recomends = pd.read_csv(path + "testRecommendation.csv")
    filtered_data = recomends[recomends.USR == int(userId)]
    beersId = filtered_data["beerId"]

    # Get Beers for given beerID
    names = pd.read_csv(path + "testBeer.csv")
    beers = names[names.beerId.isin(filtered_data.beerId)]

    # Get Beers from Result
    similars = pd.read_csv(path + "result.csv")
    filtered_data = similars[(similars.name1.isin(beers.name)) & (similars.number > 0.6)]
    filtered_data = filtered_data[filtered_data.name1 != filtered_data.name2].drop_duplicates(subset="name2")
    return filtered_data[["name2","number"]]


if __name__ == "__main__":
    path = "/Users/lrazovic/Projects/Beerer/Reccomender/dataset/"
    print(choiceBeers("1", path))
