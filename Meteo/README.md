L’objectif est de créer une application météo permettant à l’utilisateur d’ajouter des villes, et de visualiser leurs données météorologiques. Ces villes s’affichent sous forme de liste, et en cliquant sur une cellule, on ouvre une page contenant les mêmes données.
A faire :
1. Créer une listView permettant d’afficher les villes ajoutées, sous forme de liste
2. Créer un bouton “+” dans l’app, ouvrant une pop-up
3. Détails de la pop-up :
a. Un textfield pour le nom de la ville à ajouter
b. Un bouton “Annuler” et un bouton “Enregistrer”
c. Lors du clic sur “Enregistrer”, un call est effectué vers l’API openweathermap
pour récupérer les données météorologiques de la ville
4. Les villes ajoutées sont affichées sous forme de liste avec :  Nom de la ville,
Température, Condition météorologique
5. Lorsque l’utilisateur clique sur une ville, afficher une nouvelle page avec :  Nom de la
ville, Température, Condition météorologique
Requis :
● Développement en Swift 3
● Versions supportées : iOS 9 et plus
● Gestion d’erreurs (Prévoir le cas où l’utilisateur fait mauvaise saisie d’un nom de ville)
● Utiliser AutoLayout
Bonus (non obligatoire):
● Gestion de la persistance des données (CoreData, Realm...)
● Ajouter une action supprimer dans la liste au swipe sur la cellule
● Une app avec un beau design est un plus !
Astuces :
● API Meteo :   https://openweathermap.org/appid
● Librairies qui pourrait vous aider : Alamofire, SwiftyJSON
