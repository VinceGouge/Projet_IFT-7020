import pandas as pd
import numpy as np
from time import perf_counter

def wPrefersM1OverM(prefer, w, m, m1, n):
	for i in range(n):
		if (prefer[w][i] == m1):
			return True
		if (prefer[w][i] == m):
			return False
  
def stableMarriage(prefer, n):
    wPartner = [-1 for _ in range(n)]
    mFree = [False for _ in range(n)] 
    freeCount = n
    while (freeCount > 0):
        m = 0
        while (m < n):
            if (mFree[m] == False):
                break
            m += 1
        i = 0
        while i < n and mFree[m] == False:
            w = prefer[m][i]
            if (wPartner[w - n] == -1):
                wPartner[w - n] = m
                mFree[m] = True
                freeCount -= 1
 
            else:
                m1 = wPartner[w - n]
                if (wPrefersM1OverM(prefer, w, m, m1, n) == False):
                    wPartner[w - n] = m
                    mFree[m] = True
                    mFree[m1] = False
            i += 1
    print("Woman ", " Man")
    for i in range(n):
        print(i + n, "\t", wPartner[i])

def prep_row(text):
    return " ".join(text[1:-1].split())
   
def read_row(text):
    return np.asarray(text.split(" "), dtype=np.int32)

if __name__ == '__main__':
    df1 = pd.read_csv(r"C:\Users\vince\Session Hiver 2022\Optimisation combinatoire\Projet\Projet_IFT-7020\SM_dataset_employés_100.csv", engine='python') 
    df2 = pd.read_csv(r"C:\Users\vince\Session Hiver 2022\Optimisation combinatoire\Projet\Projet_IFT-7020\SM_dataset_postes_100.csv", engine='python') 
    df3 = pd.concat([df1, df2])  
    df3["liste_preference"] = df3["liste_preference"].apply(prep_row)
    arr = df3["liste_preference"].apply(read_row).values
    
    t1_start = perf_counter()
    stableMarriage(arr, len(df1))
    t1_stop = perf_counter()
    
    print(f"Temps d'exécution de l'algo (secondes) : {round(t1_stop-t1_start, 5)}")
    
    
    
# Crédit à Mohit Kumar pour les fonctions : https://www.geeksforgeeks.org/stable-marriage-problem/


