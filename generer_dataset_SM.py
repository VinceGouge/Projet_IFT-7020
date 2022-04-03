import pandas as pd
import numpy as np
if __name__ == '__main__':
    TAILLES = [10, 100, 1000, 10000]
    GROUPES = ["postes", "employés"]
    for groupe in GROUPES:
        for taille in TAILLES:
            df = pd.DataFrame(np.zeros(taille),columns=["liste_preference"])
            df["liste_preference"] = df["liste_preference"].apply(lambda x : np.random.choice(range(taille), taille, replace=False))
            df.to_csv(f"SM_dataset_{groupe}_{taille}.csv")