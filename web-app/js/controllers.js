'use strict';

function BudgetCtrl($scope, $routeParams, $resource) {
	/* The data model */
	$scope.incoming = 0;
	$scope.debts = 0;
	$scope.savings = 0;
	$scope.categories = [];
	$scope.modelsPerCategory = {};
	$scope.amountsPerCategory = {};
	$scope.amountsPerModel = {};
	
	$scope.currentCategory = "unknown";
	$scope.currentModels = [];
	
	/* Dynamic resources */
	$scope.expends = $resource('expends.json').query();
	$scope.revenues = $resource('revenues.json').get();
	
	if ( $routeParams.topicId )
		showCategory( $routeParams.topicId );
		console.log(Object.keys($routeParams));
	
	/* Extract data from the JSON to build model */
	var processRevenues = function () {
		if ($scope.revenues.income)
			$scope.incoming = $scope.revenues.income;
		if ($scope.revenues.debts)
			$scope.debts = $scope.revenues.debts;
		if ($scope.revenues.savings)
			$scope.savings = $scope.revenues.savings;
	}
	
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
	
	$scope.$watch('revenues', processRevenues, true);
	$scope.$watch('expends', processExpends, true);
	
	function formatMoneyValue(amount, currency) {
		var x1 = amount + " €";
		var rgx = /(\d+)(\d{3})/;
		while (rgx.test(x1)) {
			x1 = x1.replace(rgx, '$1' + ' ' + '$2');
		}
		return x1;
	};
	
	$scope.getCategoryAmount = function(category) {
		return formatMoneyValue($scope.amountsPerCategory[category], "€");
	};
	
	$scope.getModelAmount = function(category, model) {
		return $scope.amountsPerModel[category + "-" + model];
	};
	
	$scope.showCategory = function(category) {
		console.log("Showing models for category '"+category+"'");
		$scope.currentCategory = category;
		$scope.currentModels = $scope.modelsPerCategory[category];
	};
}
BudgetCtrl.$inject = ['$scope', '$routeParams', '$resource'];

app.controller("BudgetCtrl", BudgetCtrl);

