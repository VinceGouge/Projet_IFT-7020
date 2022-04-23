include "postes_4.dzn";
include "employes_100000.dzn";
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



%%%%%%%%%%%%%%%
% CONTRAINTES %
%%%%%%%%%%%%%%%





%%%%%%%%%%%%
% Objectif %
%%%%%%%%%%%%




%%%%%%%%%%
% Output %
%%%%%%%%%%

output ["\([Match[p] | p in POSTES])"]