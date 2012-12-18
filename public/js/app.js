'use strict';

var app = angular.module('hack4budget', ['ngResource'])
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
		.when('/', { action: "default" })
		.when('/:topicId', { action: "details" })
		.otherwise({redirectTo: '/'});
}]);

