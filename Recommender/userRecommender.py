"""
Organize the beers liked for a user
"""

import pandas as pd


def choiceBeers(userId, path):

    # Get beerID for given userId
    recomends = pd.read_csv(path + "testRecommendation.csv")
    filtered_data = recomends[recomends.USR == int(userId)]

    # Get Beers for given beerID
    names = pd.read_csv(path + "testBeer.csv")
    beers = names[names.beerId.isin(filtered_data.beerId)]

    # Get Beers from Result
    similars = pd.read_csv(path + "result.csv")
    filtered_data = similars[(similars.name1.isin(
        beers.name)) & (similars.number > 0.6)]
    filtered_data = filtered_data[filtered_data.name1 !=
                                  filtered_data.name2].drop_duplicates(subset="name2")
    filtered_data = filtered_data[["name2", "number"]]
    filtered_data = filtered_data.rename(columns={
        'name2': 'name',
        'number': 'percentage'})

    result = names[names.name.isin(
        filtered_data.name)].drop_duplicates(subset="name")
    merged_df = result.merge(filtered_data, how='left', on='name')
    return merged_df.to_json()


if __name__ == "__main__":
    path = "/Users/lrazovic/Projects/Beerer/Reccomender/dataset/"
    print(choiceBeers("1", path))
