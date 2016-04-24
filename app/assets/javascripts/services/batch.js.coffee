receta = angular.module 'batchService', ['ngResource']

receta.factory 'ClearanceBatch', ['$resource',

  ($resource) ->
    $resource 'api/clearance_batches/:id.json', {id: '@id'},
      all:
        isArray: true
      update:
        method: 'PUT'
      create:
        method: 'POST'
        transformRequest: (object) -> # incapsulate the object inside the book param
          angular.toJson item: object
]
