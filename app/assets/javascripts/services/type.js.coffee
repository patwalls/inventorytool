receta = angular.module 'typeService', ['ngResource']

receta.factory 'Type', ['$resource',

  ($resource) ->
    $resource 'api/type/:id.json', {id: '@id'},
      all:
        isArray: true
      update:
        method: 'PUT'
      destroy:
        method: 'DELETE'
        transformRequest: (object) -> # no payload in a destroy request
      create:
        method: 'POST'
        transformRequest: (object) -> # incapsulate the object inside the book param
          angular.toJson item: object
]
