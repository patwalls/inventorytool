
controllers = angular.module 'controllers', ['itemService','batchService']
controllers.controller("ItemsController", [ '$scope', '$routeParams', '$location', '$resource', 'Item','ClearanceBatch'
  ($scope,$routeParams,$location,$resource,Item,ClearanceBatch)->
    $scope.items = Item.all {}, () -> console.log($scope.items)
    $scope.clearance_batches = ClearanceBatch.all {}, () -> console.log($scope.clearance_batches)

    `$scope.sortGroup = function(key) {
      $scope.sortSelect = key;
      }`
    `$scope.createNewBatch = function() {
        $scope.entry = ClearanceBatch.create( function(data) {
          console.log(data);
          var batch = '/' + data.id;
          $location.path(batch);
          })
      }`
    `$scope.clearanceItem = function(scopeId,batchId) {
      $scope.entry = Item.get({ id: scopeId }, function() {
        $scope.entry.clearance_batch_id = batchId;
        $scope.entry.$update(function(data) {
          console.log('this was a success')
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
    `function FlashMessagesController($attrs) {
      console.log('hello world')
      this.notice = $attrs.notice;
      this.alert  = $attrs.alert;
    }`
])

    # $scope.clearanceItem = function() {
    #   var entry = Item.get({ id: '1' }, function() {
    #   console.log(entry);
    #   })`


controllers.controller("BatchController", [ '$scope', '$routeParams', '$location', '$resource', 'Item','ClearanceBatch'
  ($scope,$routeParams,$location,$resource,Item,ClearanceBatch)->
    $scope.items = Item.all {}, () -> console.log($scope.items)
    $scope.clearance_batches = ClearanceBatch.all {}, () -> console.log($scope.clearance_batches)

    `$scope.getBatchStatus = function(batchId) {
      var status = '';
      $scope.clearance_batches.forEach(function(batch) {
          if (batchId == batch.id) {
            batch.submitted ? status = 'Submitted' : status = 'In Progress';
          }
        });
        return status;
      }`

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
