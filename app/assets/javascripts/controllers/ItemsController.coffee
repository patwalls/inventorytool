
controllers = angular.module 'controllers', ['itemService']
controllers.controller("ItemsController", [ '$scope', '$routeParams', '$location', '$resource', 'Item'
  ($scope,$routeParams,$location,$resource,Item,Style)->
    $scope.items = Item.all {}, () -> console.log($scope.items)

    `$scope.sortGroup = function(key) {
      $scope.sortSelect = key;
      }`
    `$scope.clearanceItem = function(scopeId,batchId) {
      $scope.entry = Item.get({ id: scopeId }, function() {
        $scope.entry.clearance_batch_id = batchId;
        $scope.entry.$update(function(data) {
          $scope.items[scopeId - 1] = $scope.entry;
        },function(error) {
          console.log(error)
          });
      });
    }`
    `$scope.changeView = function(batchId){
      var batch = '/' + batchId;
      $location.path(batchId);
    }`
])

    # $scope.clearanceItem = function() {
    #   var entry = Item.get({ id: '1' }, function() {
    #   console.log(entry);
    #   })`


controllers.controller("BatchController", [ '$scope', '$routeParams', '$location', '$resource', 'Item'
  ($scope,$routeParams,$location,$resource,Item)->
    $scope.items = Item.all {}, () -> console.log($scope.items)
    `$scope.sortGroup = function(key) {
      $scope.sortSelect = key;
      }`
    `$scope.batchId = $routeParams.id`
    `$scope.unClearanceItem = function(scopeId) {
      $scope.entry = Item.get({ id: scopeId }, function() {
        $scope.entry.clearance_batch_id = null;
        $scope.entry.$update(function(data) {
          $scope.items[scopeId - 1] = $scope.entry;
        },function(error) {
          console.log(error)
          });
      });
    }`
    `$scope.goToIndex = function(){
      var batch = '/';
      $location.path(batch);
    }`
])

# app = angular.module 'itemsController', ['itemService', 'bookRow']
#
# app.controller 'ItemsController', ['$scope', 'Item',
#   ($scope, Item) ->
#     $scope.items = Item.all {}
# ]
