"""
Recommender System
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


def read_data(path):
    """ Reads in the dataset, and filters down ratings down to positive only"""
    ratings = pandas.read_csv(path + "testRecommendation.csv")
    positive = ratings[ratings.rating >= 1]
    beers = pandas.read_csv(path + "testBeer.csv")
    m = coo_matrix((positive['rating'].astype(numpy.int32),
                    (positive['beerId'], positive['USR'])))
    m.data = numpy.ones(len(m.data))
    return ratings, beers, m


def calculate_similar_beers(input_path, output_filename, model_name="cosine"):
    # read in the input data file
    logging.debug("reading data from %s", input_path)
    start = time.time()
    ratings, beers, m = read_data(input_path)
    logging.debug("read data file in %s", time.time() - start)

    # generate a recommender model based off the input params
    if model_name == "als":
        model = AlternatingLeastSquares()

        # lets weight these models by bm25weight.
        logging.debug("weighting matrix by bm25_weight")
        m = bm25_weight(m,  B=0.9) * 5

    elif model_name == "bpr":
        model = BayesianPersonalizedRanking()

    elif model_name == "tfidf":
        model = TFIDFRecommender()

    elif model_name == "cosine":
        model = CosineRecommender()

    elif model_name == "bm25":
        model = BM25Recommender(B=0.2)

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

    with open(output_filename, "w") as o:
        for beerId in to_generate:
            if m.indptr[beerId] == m.indptr[beerId + 1]:
                continue
            beer = beer_lookup[beerId]
            for other, score in model.similar_items(beerId, 11):
                o.write("%s,%s,%s\n" % (beer, beer_lookup[other], score))

if __name__ == "__main__":
    """
    parser = argparse.ArgumentParser(description="Generates related movies from the MovieLens 20M "
                                                 "dataset (https://grouplens.org/datasets/movielens/20m/)",
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('--input', type=str,
                        dest='inputfile', help='Path of the unzipped ml-20m dataset', required=True)
    parser.add_argument('--output', type=str, default='similar-movies.tsv',
                        dest='outputfile', help='output file name')
    parser.add_argument('--model', type=str, default='als',
                        dest='model', help='model to calculate (als/bm25/tfidf/cosine)')
    parser.add_argument('--min_rating', type=float, default=4.0, dest='min_rating',
                        help='Minimum rating to assume that a rating is positive')
    args = parser.parse_args()
    """

    logging.basicConfig(level=logging.DEBUG)
    """
    calculate_similar_beers(args.inputfile, args.outputfile,
                             model_name=args.model)
    """
    input = "/home/ale96/Documents/beerer/Beerer/.idea/src/dataset/"
    output = "/home/ale96/Documents/beerer/Beerer/.idea/src/dataset/result.csv"
    calculate_similar_beers(input, output, "cosine")