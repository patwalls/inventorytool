
controllers = angular.module 'controllers', ['itemService']
controllers.controller("ItemsController", [ '$scope', '$routeParams', '$location', '$resource', 'Item'
  ($scope,$routeParams,$location,$resource,Item,Style)->
    $scope.items = Item.all {}, () -> console.log($scope.items)
    `$scope.sortGroup = function(key) {
      $scope.sortSelect = key;
      }`
])

controllers.controller("BatchController", [ '$scope', '$routeParams', '$location', '$resource', 'Item'
  ($scope,$routeParams,$location,$resource,Item)->
    $scope.items = Item.all {}, () -> console.log($scope.items)
    `$scope.sortGroup = function(key) {
      $scope.sortSelect = key;
      }`
    `$scope.batchId = $routeParams.id`
])

# app = angular.module 'itemsController', ['itemService', 'bookRow']
#
# app.controller 'ItemsController', ['$scope', 'Item',
#   ($scope, Item) ->
#     $scope.items = Item.all {}
# ]
