Ce projet s'est déroulé tout au long du semestre et s'inscrit dans le cadre des unités d'enseignement FDD-XML et Java. Il consiste à développer une application Web permettant de gérer le problème du "voyageur de santé".

Objectif du Projet:
Le but est de créer un logiciel pour organiser et optimiser les déplacements des infirmier(e)s du cabinet infirmier Soins à Grenoble. Le cabinet emploie actuellement une secrétaire médicale et trois infirmières, mais il pourrait s'agrandir à l'avenir.

Contexte:
Chaque jour, les infirmières font le tour de leurs patients pour des soins. La secrétaire médicale entre la liste des patients à visiter ainsi que leurs coordonnées et toutes informations utiles aux soins. Elle affecte ensuite les patients à chaque infirmière. Lorsqu'une infirmière s'identifie sur l'application, elle obtient la liste des patients à visiter, ordonnée pour optimiser son trajet quotidien. Elle peut également obtenir la facture correspondant à chaque patient.

Modélisation du Cabinet Infirmier:
Le projet se concentrera principalement sur la modélisation du cabinet d'infirmiers et les transformations XSLT associées. Les données seront stockées, lues, écrites et transformées en format XML. Les étapes de modélisation comprennent :

Développement du modèle de cabinet en XMLSchema:
- Création d'une instance de cabinet en XML.
- Réalisation de transformations XSLT pour extraire les données des patients et la liste des interventions d'une infirmière.
Organisation de l'Application
- L'application se présentera sous la forme d'un Web Service, qui pourra être développé en fin de projet en fonction du temps disponible. Ce Web Service permettra aux soignants de se connecter à distance pour obtenir divers services et renseignements, tels que la facturation client, la liste des patients à visiter, et le trajet optimal pour les visites.

Scénario d'Utilisation:
Deux types de clients peuvent utiliser le serveur : la secrétaire médicale et l'infirmière.

Actions de la Secrétaire Médicale
Prises en charge intégralement via le système d'interface (IHM).
Actions de l'Infirmière
L'infirmière envoie une requête via l'IHM pour obtenir le trajet de la tournée de la journée.
Le serveur métier reçoit la requête et transmet la réponse attendue (fichier XML ou page HTML développée en LW).
Le module LW du serveur métier envoie une requête à GoogleMap API pour obtenir les matrices de distances des adresses des patients.
Le serveur récupère la réponse sous forme de matrices de distances dans un fichier XML.
