import pandas as pd
import json


def choice_beers(userId, path):

    # Get beerID for given userId
    recomends = pd.read_csv(path + "testRecommendation.csv")
    filtered_data = recomends[recomends.USR == int(userId)]
    # print(filtered_data)

    # Get Beers for given beerID
    names = pd.read_csv(path + "testBeer.csv")
    beers = names[names.beerId.isin(filtered_data.beerId)]

    # Get Beers from Result
    similars = pd.read_csv(path + "result.csv")
    filtered_data = similars[
        (similars.name1.isin(beers.name)) & (similars.number > 0.75)
    ]
    filtered_data = filtered_data[
        filtered_data.name1 != filtered_data.name2
    ].drop_duplicates(subset="name2")
    filtered_data = filtered_data[["name2", "number"]]
    filtered_data = filtered_data.rename(
        columns={"name2": "name", "number": "likelihood"}
    )
    result = names[names["name"].isin(list(filtered_data.name))]
    merged_df = result.merge(filtered_data, how="left", on="name")
    merged_df = merged_df.sort_values(by="likelihood", ascending=False)
    return json.loads(merged_df.to_json(orient="records"))


if __name__ == "__main__":
    path = "dataset/"
    info = choice_beers("1", path)
    print(info)
