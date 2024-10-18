// Write by Coolboard
//
// Activation controle du brouillard
//
// time_value setFog [fogValue,fogDecay,fogBase]

//--- Preparation de la commande à la nouvelle structure ---

//--- Définitions de variables statiques pour le brouillard Humidité ---
humidityFogValue=0.15;
humidityFogDecay=0.1;
humidityFogBase=15;


//----------------------------------------------------------------------------------------------
/*---DESACTIVER POUR LE MOMENT---
//--- generation d'une classe Humidity ---
class Humidity {
    class Functions {
        file="gfoo";  // Spécifie le répertoire
        class applyFog {
            preInit=1; // Pour s'assurer que la fonction est appelée dès le début
            description="Applies humidity fog settings.";
            //code="0 setFog [0.15, 0.1, 15];"; // Pas besoin de 'code' ici, car nous allons appeler cette fonction dans le script fogApply.sqf
        };
    };
};
*/


/*---!!! Ancienne commande, ne fonctionne plus avce la nouvelle structure !!!---
//Configuration pôur un brouillard de surface envirronnement marine
hint "Mise en place de l'humidité"
10 setFog [0.15,0.1,15];
diag_log "Humidité appliquée";

// Others kind of fogBase
//
//0 setFog [0.2,0.4,5];
//
//Configuration pour un brouillard de sol avec plafond à 50m
//0 setFog [0.1,0.15,50];
//
//Configuration pour un brouillard de sol avec plafond à 100m
//0 setFog [0.01,0.30,100];
//
// Configuration sans aucun brouillard
// 0 setFog [0,0,0];
// 0 setFog 0;
*/