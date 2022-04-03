include "employes_1000.dzn";
include "postes_2.dzn";
include "alldifferent.mzn";

%%%%%%%%%%%%%%
% CONSTANTES %
%%%%%%%%%%%%%%

% Constantes globales
int: NB_EMPLOYES;
int: NB_POSTES;
set of int: EMPLOYES = 1..NB_EMPLOYES;
set of int: POSTES = 1..NB_POSTES;
set of int: DIX_COLONNES = 1..10;
set of int: UNE_COLONNE = 1..1;
set of int: NIVEAUX_HIERARCHIQUES = 1..3;
set of int: NIVEAUX_EDUCATION = 1..7;
set of int: NIVEAUX_LANGUES = 1..4;
set of int: TITRES_PROFESSIONNELS = 0..6;

% Constantes des employés
array[EMPLOYES, UNE_COLONNE] of NIVEAUX_HIERARCHIQUES: NIVEAU_HIERARCHIQUE_E;
array[EMPLOYES, DIX_COLONNES] of int: COMP_CLEES_E;
array[EMPLOYES, DIX_COLONNES] of int: AUTRES_COMP_E;
array[EMPLOYES, UNE_COLONNE] of NIVEAUX_EDUCATION: NIVEAU_EDUCATION_E;
array[EMPLOYES, UNE_COLONNE] of TITRES_PROFESSIONNELS: TITRE_PROFESSIONNEL_E;
array[EMPLOYES, UNE_COLONNE] of NIVEAUX_LANGUES: NIVEAU_FR_E;
array[EMPLOYES, UNE_COLONNE] of NIVEAUX_LANGUES: NIVEAU_EN_E;
array[EMPLOYES, DIX_COLONNES] of int: AUTRES_LANGUES_E;

% Constantes des postes
array[POSTES, UNE_COLONNE] of NIVEAUX_HIERARCHIQUES: NIVEAU_HIERARCHIQUE_P;
array[POSTES, DIX_COLONNES] of int: COMP_CLEES_P;
array[POSTES, DIX_COLONNES] of int: AUTRES_COMP_P;
array[POSTES, UNE_COLONNE] of NIVEAUX_EDUCATION: NIVEAU_EDUCATION_P;
array[POSTES, UNE_COLONNE] of TITRES_PROFESSIONNELS: TITRE_PROFESSIONNEL_P;
array[POSTES, UNE_COLONNE] of NIVEAUX_LANGUES: NIVEAU_FR_P;
array[POSTES, UNE_COLONNE] of NIVEAUX_LANGUES: NIVEAU_EN_P;
array[POSTES, DIX_COLONNES] of int: AUTRES_LANGUES_P;


%%%%%%%%%%%%%
% VARIABLES %
%%%%%%%%%%%%%
array[POSTES] of var 0..NB_EMPLOYES: Match; % Indice de l'employé associé à chaque poste
array[POSTES, DIX_COLONNES] of var 0..1: COMP_CLEES_Match; % Compétenses clées en commun entre le poste et l'employé associé au poste
array[POSTES, DIX_COLONNES] of var 0..1: AUTRES_COMP_Match; % Autres compétenses en commun entre le poste et l'employé associé au poste
array[POSTES, DIX_COLONNES] of var 0..1: AUTRES_LANGUES_Match; % Autres langues en commun entre le poste et l'employé associé au poste

% Variable de pénalité sur les différentes contraintes "soft"
array[POSTES] of var int: Penalite_COMP_CLEES;
array[POSTES] of var int: Penalite_AUTRES_COMP;
array[POSTES] of var int: Penalite_AUTRES_LANGUES;
array[POSTES] of var int: Penalite_Education;
array[POSTES] of var int: Penalite_FR;
array[POSTES] of var int: Penalite_EN;


%%%%%%%%%%%%%%%
% CONTRAINTES %
%%%%%%%%%%%%%%%

% Contraintes "hard" devant absolument être satisfaites (niveau hiérarchique et titre prof. égale entre poste et employé)
constraint forall(p in POSTES) ([NIVEAU_HIERARCHIQUE_E[Match[p], c] | c in UNE_COLONNE] = [NIVEAU_HIERARCHIQUE_P[p, c] | c in UNE_COLONNE]);
constraint forall(p in POSTES) ([TITRE_PROFESSIONNEL_E[Match[p], c] | c in UNE_COLONNE] = [TITRE_PROFESSIONNEL_P[p, c] | c in UNE_COLONNE]);
constraint alldifferent(Match);

% Vecteurs des compétences clées, autres compétence et autres langues en commun entre le poste et l'employé assigné au poste
constraint forall(p in POSTES) (forall(c in DIX_COLONNES) (COMP_CLEES_P[p, c] = 1 /\ COMP_CLEES_E[Match[p], c] = 1 -> COMP_CLEES_Match[p, c] = 1));
constraint forall(p in POSTES) (forall(c in DIX_COLONNES) (AUTRES_COMP_P[p, c] = 1 /\ AUTRES_COMP_E[Match[p], c] = 1 -> AUTRES_COMP_Match[p, c] = 1));
constraint forall(p in POSTES) (forall(c in DIX_COLONNES) (AUTRES_LANGUES_P[p, c] = 1 /\ AUTRES_LANGUES_E[Match[p], c] = 1 -> AUTRES_LANGUES_Match[p, c] = 1));

% Contraintes "soft" devant être satisfaites le plus possible mais admettant une certaine pénalité
constraint forall(p in POSTES) (sum(c in DIX_COLONNES) (COMP_CLEES_Match[p, c]) + Penalite_COMP_CLEES[p] = sum(c in DIX_COLONNES) (COMP_CLEES_P[p, c]));
constraint forall(p in POSTES) (sum(c in DIX_COLONNES) (AUTRES_COMP_Match[p, c]) + Penalite_AUTRES_COMP[p] = sum(c in DIX_COLONNES) (AUTRES_COMP_P[p, c]));
constraint forall(p in POSTES) (sum(c in DIX_COLONNES) (AUTRES_LANGUES_Match[p, c]) + Penalite_AUTRES_LANGUES[p] = sum(c in DIX_COLONNES) (AUTRES_LANGUES_P[p, c]));
constraint forall(p in POSTES) (NIVEAU_EDUCATION_E[Match[p], 1] + Penalite_Education[p] = NIVEAU_EDUCATION_P[p, 1]);
constraint forall(p in POSTES) (NIVEAU_FR_E[Match[p], 1] + Penalite_FR[p] = NIVEAU_FR_P[p, 1]);
constraint forall(p in POSTES) (NIVEAU_EN_E[Match[p], 1] + Penalite_EN[p] = NIVEAU_EN_P[p, 1]);



%%%%%%%%%%%%
% Objectif %
%%%%%%%%%%%%
solve minimize sum(p in POSTES)(abs(Penalite_COMP_CLEES[p])) + sum(p in POSTES)(abs(Penalite_Education[p])) + sum(p in POSTES)(abs(Penalite_FR[p])) + sum(p in POSTES)(abs(Penalite_EN[p])) + sum(p in POSTES)(abs(Penalite_AUTRES_COMP[p])) + sum(p in POSTES)(abs(Penalite_AUTRES_LANGUES[p]));


%%%%%%%%%%
% Output %
%%%%%%%%%%

output ["\([Match[p] | p in POSTES])" ++ "\n" ++
        "\([Penalite_Education[p] | p in POSTES])" ++ "\n" ++
        "\([Penalite_FR[p] | p in POSTES])" ++ "\n" ++
        "\([Penalite_EN[p] | p in POSTES])" ++ "\n" ++
        "\(sum(p in POSTES)(abs(Penalite_COMP_CLEES[p])) + sum(p in POSTES)(abs(Penalite_Education[p])) + sum(p in POSTES)(abs(Penalite_FR[p])) + sum(p in POSTES)(abs(Penalite_EN[p])) + sum(p in POSTES)(abs(Penalite_AUTRES_COMP[p])) + sum(p in POSTES)(abs(Penalite_AUTRES_LANGUES[p])))"]