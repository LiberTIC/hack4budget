'use strict';

var app = angular.module('hack4budget', ['ngResource'])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
		.when('/', { controller: BudgetCtrl })
		.when('/:topicId', { controller: BudgetCtrl })
		.otherwise({redirectTo: '/'});
}]);

