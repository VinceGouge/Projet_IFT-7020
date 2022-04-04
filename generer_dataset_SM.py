import pandas as pd
import numpy as np
from ast import literal_eval

def rand_arr(text):
    return np.random.choice(range(10), 10, replace=False)

if __name__ == '__main__':
    """
    TAILLES = [10, 100, 1000, 10000]
    GROUPES = ["postes", "employés"]
    for groupe in GROUPES:
        for taille in TAILLES:
            df = pd.DataFrame(np.zeros(taille),columns=["liste_preference"])            
            df["liste_preference"] = df["liste_preference"].apply(lambda x : np.random.choice(range(taille), taille, replace=False))
            df.to_csv(f"SM_dataset_{groupe}_{taille}.csv")"""
            
    df = pd.DataFrame(np.zeros(10),columns=["liste_preference"])            
    df["liste_preference"] = df["liste_preference"].apply(func=rand_arr)
    arr = df["liste_preference"][0]
    #arr = arr[1:-1].split(',')
    print(arr)
    print(type(arr))
    print(df.dtypes) 
    print(df.head())     