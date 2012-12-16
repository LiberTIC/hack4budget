'use strict';

////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////// APPLICATION
////////////////////////////////////////////////////////////////////////////////

var app = angular.module('hack4budget', []).
	config(['$routeProvider', function($routeProvider) {
		$routeProvider
		.when('/', { controller: BudgetCtrl })
		.when('/:topicId', { controller: BudgetCtrl })
		.otherwise({redirectTo: '/'});
}]);

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////// CONTROLERS
////////////////////////////////////////////////////////////////////////////////

app.controller("BudgetCtrl", 
	function BudgetCtrl($scope, $routeParams) {
		$scope.test = "Test";
		
		$scope.revenu = {
			"income": 100000,
			"debts": 1000,
			"savings": 0
		};
	
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
  $scope.name = 'Guest';
});

function BudgetCtrl($scope, $routeParams) {

}
BudgetCtrl.$inject = ['$scope', '$routeParams'];

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////// VIEWS
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////// DIRECTIVES
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// SERVICES
////////////////////////////////////////////////////////////////////////////////



