'use strict';

function BudgetCtrl($scope, $routeParams, $resource) {
	$scope.expends = $resource('expends.json').query();
	$scope.categories = [];
	$scope.modelsPerCategory = {};
	$scope.amountsPerCategory = {};
	$scope.amountsPerModel = {};
	
	/* Extract data from the JSON to build model */
	var processExpends = function () {
		for(var i=0 ; i<$scope.expends.length ; i++) {
			// Get the data
			var category = $scope.expends[i]["_id"]["category"];
			var model = $scope.expends[i]["_id"]["model"];
			var amount = $scope.expends[i]["sum"];
			if (!category) continue;
			if (!model) continue;
			if (!amount) continue;
			
			// Push data model per category
			if ( $scope.categories.indexOf(category) < 0 )
				$scope.categories.push(category);
			if ( ! $scope.amountsPerCategory[category] )
				$scope.amountsPerCategory[category] = 0;
			$scope.amountsPerCategory[category] += amount;
			
			// Push data model per model
			if ( ! $scope.modelsPerCategory[category] )
				$scope.modelsPerCategory[category] = [];
			$scope.modelsPerCategory[category].push(model);
			var modelKey = category + "-" + model;
			if ( ! $scope.amountsPerModel[modelKey] )
				$scope.amountsPerModel[modelKey] = 0;
			$scope.amountsPerModel[modelKey] += amount;
		}
		console.log("Should be loaded...");
		console.log("Size :" + $scope.expends.length);
	};
	
	$scope.$watch('expends', processExpends, true);
	
	$scope.test = "Test";
	
	$scope.revenu = {
		"income": 100000,
		"debts": 1000,
		"savings": 0
	};
/*
		$scope.expends = {
			"economy": {
				"label": "Économie",
				"icon": "img/economie.png",
				"categories": ["Divers", "Frais de fonctionnement", "Subventions"]
			},
			"urbanism": {
				"label": "Urbanisme",
				"icon": "img/urbanisme.png",
				"categories": ["AUTRES", "GENERAL", "IMMOBILISATION INCORPORELES", "IMMOBILISATIONS CORPORELLES", "IMMOBILISATIONS EN COURS", "IMMOBILISATIONS INCORPORELLES", "PERSONNEL", "SUBVENTIONS D'EQUIPEMENT VERSEES", "SUBVENTIONS D'INVESTISSEMENT"]
			},
			"social": {
				"label": "Social",
				"icon": "img/social.png",
				"categories": ["Enfants / Ado", "Famille", "Global – Divers", "Global - Personnel", "Global – Subvention", "Logement", "Personnes Agées", "Santé", "Santé - Personnel"]
			},
			"education": {
				"label": "Éducation",
				"icon": "img/education.png",
				"categories": ["autres", "communication", "fonctionnement", "fournitures", "immobilisation", "immobilisations", "personnel", "subvention"]
			},
			"environment": {
				"label": "Environnement",
				"icon": "img/environment.png",
				"categories": ["autres", "communication", "fonctionnement", "personnel", "subvention"]
			},
			"culture": {
				"label": "Culture",
				"icon": "img/culture.png",
				"categories": ["COMMUNICATION", "Divers", "DOCUMENTATIONS OEUVRES", "FOURNITURES", "FRAIS DE PERSONNEL", "FRAIS MOBILIERS ET IMMOBILIERS", "IMPOTS", "CREANCES", "PRESTATIONS DE SERVICES", "RECHERCHE SUBVENTIONS", "TRANSPORT DE PERSONNES ET DE BIENS"]
			},
			"administration": {
				"label": "Administration",
				"icon": "img/administratif.png",
				"categories": ["Communication", "Dette", "Divers", "Élus", "Fiscalité", "Frais de fonctionnement", "Immobilier", "Personnel", "Subventions"]
			}
		};
*/
}
BudgetCtrl.$inject = ['$scope', '$routeParams', '$resource'];

app.controller("BudgetCtrl", BudgetCtrl);

