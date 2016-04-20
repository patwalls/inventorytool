receta = angular.module 'itemService', ['ngResource']

receta.factory 'Item', ['$resource',

  ($resource) ->
    $resource '/items', {},
      all:
        isArray: true
      update:
        method: 'PUT'
        transformRequest: (object) -> # incapsulate the object inside the book param
          angular.toJson item: object
      destroy:
        method: 'DELETE'
        transformRequest: (object) -> # no payload in a destroy request
      create:
        method: 'POST'
        transformRequest: (object) -> # incapsulate the object inside the book param
          angular.toJson item: object
]

receta.factory 'Style', ['$resource',

  ($resource) ->
    $resource '/style', {},
      all:
        isArray: true
      update:
        method: 'PUT'
        transformRequest: (object) -> # incapsulate the object inside the book param
          angular.toJson item: object
      destroy:
        method: 'DELETE'
        transformRequest: (object) -> # no payload in a destroy request
      create:
        method: 'POST'
        transformRequest: (object) -> # incapsulate the object inside the book param
          angular.toJson item: object
]
