receta = angular.module 'styleService', ['ngResource']

receta.factory 'Style', ['$resource',

  ($resource) ->
    $resource 'api/style/:id.json', {id: '@id'},
      all:
        isArray: true
]
