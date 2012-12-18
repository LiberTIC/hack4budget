'use strict';

var services = angular.module('hack4budget.services', []);

services.factory('ExpendsService',
   ['$resource', function($resource) {
     return $resource(
         'data.json',
         {},
         {
           query: {
             method:'GET',
             params:{},
             isArray:false
           }
         }
       );
   }]);

