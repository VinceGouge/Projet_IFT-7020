include "stable_mariage_1.dzn";

%%%%%%%%%%%%%%
% CONSTANTES %
%%%%%%%%%%%%%%
int: NB_EMPLOYES;
int: NB_POSTES;

set of int: EMPLOYES = 1..NB_EMPLOYES; 
set of int: POSTES = 1..NB_POSTES;

array[EMPLOYES, POSTES] of int: RANGS_EMPLOYES;
array[POSTES, EMPLOYES] of int: RANGS_POSTES;

%%%%%%%%%%%%%
% VARIABLES %
%%%%%%%%%%%%%
array[EMPLOYES] of var POSTES: postes_assignes;
array[POSTES] of var EMPLOYES: employes_assignes;

%%%%%%%%%%%%%%%
% CONTRAINTES %
%%%%%%%%%%%%%%%
% Le l'employé assigné au poste de l'employé e doit être l'employé e
constraint forall(e in EMPLOYES) (employes_assignes[postes_assignes[e]] = e);
% Le poste assigné à l'employé du poste p est le poste p
constraint forall(p in POSTES) (postes_assignes[employes_assignes[p]] = p);

% Si l'employé e se voit assigner un pire poste, c'est parce qu'il est un meilleur employé pour le poste.
constraint forall (e in EMPLOYES) (forall(p in POSTES) (RANGS_EMPLOYES[e,p] < RANGS_EMPLOYES[e,postes_assignes[e]] -> 
                                                        RANGS_POSTES[p,employes_assignes[p]] < RANGS_POSTES[p,e]));
                                                        
% Si Le poste se voit assigner un pire employé, c'est parce qu'il est un meilleur poste pour l'employé.                                                       
constraint forall (p in POSTES) (forall(e in EMPLOYES) (RANGS_POSTES[p,e] < RANGS_POSTES[p,employes_assignes[p]] -> 
                                                        RANGS_EMPLOYES[e,postes_assignes[e]] < RANGS_EMPLOYES[e,p]));
                                                        
%%%%%%%%%%%%%%%%
%   OBJECTIF   %
%%%%%%%%%%%%%%%%
solve satisfy;

output ["\n" ++ "---- Postes et employés assignés ----" ++ "\n"
        ++ "Postes   " ++ "\([POSTES[p]|p in POSTES])" ++ "\n"
        ++ "Employés " ++ "\(employes_assignes)" ++ "\n"]
