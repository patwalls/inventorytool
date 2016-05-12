receta = angular.module 'itemService', ['ngResource']

receta.factory 'Item', ['$resource'
  ($resource) ->
    $resource 'api/items/:id.json', {id: '@id'},
      all:
        isArray: true
      update:
        method: 'PUT'

]
