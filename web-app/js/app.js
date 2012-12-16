'use strict';

var app = angular.module('hack4budget', ['ngResource'])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
		.when('/:topicId', { controller: BudgetCtrl })
		.otherwise({redirectTo: '/SOCIAL'});
}]);

