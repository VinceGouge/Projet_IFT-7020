import numpy as np


def generateData(num):

    NIVEAU_HIERARCHIQUE = np.random.randint(1, 4, size=(num, 1))
    NIVEAU_EDUCATION = np.random.randint(1, 8, size=(num, 1))
    TITRE_PROFESSIONNEL = np.random.randint(0, 7, size=(num, 1))
    NIVEAU_FR = np.random.randint(1, 5, size=(num, 1))
    NIVEAU_EN = np.random.randint(1, 5, size=(num, 1))

    COMP_CLEES = np.zeros((num, 10), dtype=int)
    AUTRES_COMP = np.zeros((num, 10), dtype=int)
    AUTRES_LANGUES = np.zeros((num, 10), dtype=int)
    param10 = [COMP_CLEES, AUTRES_COMP, AUTRES_LANGUES]
    probs10 = [0.6, 0.4, 0.1]

    for param, prob in zip(param10, probs10):
        probsArray = np.random.rand(num, 10)
        for i in range(num):
            for j in range(10):
                if(probsArray[i][j] < prob):
                    param[i][j] = 1

    return [NIVEAU_HIERARCHIQUE, COMP_CLEES, AUTRES_COMP, NIVEAU_EDUCATION, TITRE_PROFESSIONNEL, NIVEAU_FR, NIVEAU_EN, AUTRES_LANGUES]

f = open("data.txt", "a")

num = 6

#fieldNames = ['NIVEAU_HIERARCHIQUE_E', 'COMP_CLEES_E', 'AUTRES_COMP_E', 'NIVEAU_EDUCATION_E', 'TITRE_PROFESSIONNEL_E', 'NIVEAU_FR_E', 'NIVEAU_EN_E', 'AUTRES_LANGUES_E']
#f.write("NB_EMPLOYES = {};\n\n".format(num))

fieldNames = ['NIVEAU_HIERARCHIQUE_P', 'COMP_CLEES_P', 'AUTRES_COMP_P', 'NIVEAU_EDUCATION_P', 'TITRE_PROFESSIONNEL_P', 'NIVEAU_FR_P', 'NIVEAU_EN_P', 'AUTRES_LANGUES_P']
f.write("NB_POSTES = {};\n\n".format(num))

data = generateData(num)
for name, field in zip(fieldNames, data):
    f.write("{} = [".format(name))
    for value in field:
        f.write("|")
        for number in value:
            f.write("{}, ".format(number))
        f.write("\n")
    f.write("|];\n\n")
f.close()