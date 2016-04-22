receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'services',
  'ngSanitize',
  'ngCsv'
])

receta.config([ '$routeProvider','$httpProvider',
  ($routeProvider,$httpProvider)->
    $routeProvider
      .when '/',
        templateUrl: "index.html"
        controller: 'ItemsController'
      .when '/:id',
        templateUrl: "batch.html"
        controller: 'BatchController'

])


services = angular.module('services',[])
controllers = angular.module('controllers',[])
