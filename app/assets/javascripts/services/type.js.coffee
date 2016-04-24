receta = angular.module 'typeService', ['ngResource']

receta.factory 'Type', ['$resource',

  ($resource) ->
    $resource 'api/type/:id.json', {id: '@id'},
      all:
        isArray: true
      update:
        method: 'PUT'
]
