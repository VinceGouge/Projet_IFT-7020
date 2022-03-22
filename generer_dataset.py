import numpy as np
import pandas as pd
import random as rd

def get_rand_arr(low:int, high:int, size:int=50) -> np.array:
    return np.random.randint(low, high+1, size).astype(int)

def get_list_of_rand_arr(low:int, high:int, size:int=50, min_size_arr:int=1, max_size_arr:int=10) -> list:
    return [get_rand_arr(low, high, rd.randint(min_size_arr,max_size_arr)) for _ in range(size)]

if __name__ == '__main__':
    
    NB_EMP = 50
    NB_POSTES = 15
    
    # Les NB_EMP employés internes
    df = pd.DataFrame()
    df["Niveau Hierarchique"] = get_rand_arr(1, 3, NB_EMP)
    df["Competences Clees"] = get_list_of_rand_arr(1, 10, NB_EMP)
    df["Autres Competences"] = get_list_of_rand_arr(1, 10, NB_EMP, 1, 5)
    df["Niveau Education"] = get_rand_arr(1, 7, NB_EMP)
    df["Titre Professionnel"] = get_rand_arr(0, 6, NB_EMP)
    df["Niveau Fr"] = get_rand_arr(1, 4, NB_EMP)
    df["Niveau En"] = get_rand_arr(1, 4, NB_EMP)
    df["Autres Langues"] = get_list_of_rand_arr(1, 10, NB_EMP, 1, 2)
    
    df.to_csv("employes_1.csv", header=False, index=False)


    # Les NB_POSTES Postes disponibles
    df = pd.DataFrame()
    df["Niveau Hierarchique"] = get_rand_arr(1, 3, NB_POSTES)
    df["Competences Clees"] = get_list_of_rand_arr(1, 10, NB_POSTES, 1, 5)
    df["Autres Competences"] = get_list_of_rand_arr(1, 10, NB_POSTES, 1, 5)
    df["Niveau Education"] = get_rand_arr(1, 7, NB_POSTES)
    df["Titre Professionnel"] = get_rand_arr(0, 6, NB_POSTES) # 95% de zéros
    df["Niveau Fr"] = get_rand_arr(1, 4, NB_POSTES)
    df["Niveau En"] = get_rand_arr(1, 4, NB_POSTES)
    df["Autres Langues"] = get_list_of_rand_arr(1, 10, NB_POSTES, 1, 1)   
    
    
    df.to_csv("postes_1.csv", header=False, index=False)    