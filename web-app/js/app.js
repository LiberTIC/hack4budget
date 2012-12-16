'use strict';

var app = angular.module('hack4budget', ['hack4budgetControllers', 'hack4budgetServices']).
	config(['$routeProvider', function($routeProvider) {
		$routeProvider
		.when('/', { controller: BudgetCtrl })
		.when('/:topicId', { controller: BudgetCtrl })
		.otherwise({redirectTo: '/'});
}]);

