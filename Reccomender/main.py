from __future__ import print_function

import argparse
import logging
import os
import time
import numpy
import pandas
from scipy.sparse import coo_matrix

from implicit.als import AlternatingLeastSquares
from implicit.nearest_neighbours import (BM25Recommender, CosineRecommender,
                                         TFIDFRecommender, bm25_weight)


def read_data():
    """ Reads in the dataset, and filters down ratings down to positive only"""
    ratings = pandas.read_csv("/Users/lrazovic/Desktop/idea/src/Files/testRecommendation.csv")
    positive = ratings[ratings.rating >= 1]
    beers = pandas.read_csv("/Users/lrazovic/Desktop/idea/src/Files/testBeer.csv")
    m = coo_matrix((positive['rating'].astype(numpy.int32),
                    (positive['beerId'], positive['USR'])))
    m.data = numpy.ones(len(m.data))
    return ratings, beers, m


def calculate_similar_beers():
    # read in the input data file
    start = time.time()
    ratings, beers, m = read_data()
    model_name = "cosine"

    if model_name == "cosine":
        model = CosineRecommender()

    else:
        raise NotImplementedError("TODO: model %s" % model_name)

    # train the model
    m = m.tocsr()
    logging.debug("training model %s", model_name)
    start = time.time()
    model.fit(m)
    logging.debug("trained model '%s' in %s", model_name, time.time() - start)
    logging.debug("calculating top beers")

    user_count = ratings.groupby('beerId').size()
    beer_lookup = dict((i, m) for i, m in zip(beers['beerId'], beers['name']))
    to_generate = sorted(list(beers['beerId']), key=lambda x: -user_count.get(x, 0))

    with open('/Users/lrazovic/Desktop/idea/src/Files/result.csv', "w") as o:
        for beerId in to_generate:
            if m.indptr[beerId] == m.indptr[beerId + 1]:
                continue
            beer = beer_lookup[beerId]
            for other, score in model.similar_items(beerId, 11):
                o.write("%s\t%s\t%s\n" % (beer, beer_lookup[other], score))


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    calculate_similar_beers()
