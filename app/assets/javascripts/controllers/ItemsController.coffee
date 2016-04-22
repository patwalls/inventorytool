
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
          $scope.entry = Item.get({ id: scopeId }, function() {
            $scope.items[scopeId - 1] = $scope.entry;
          });
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
    `
      $scope.exportData = function () {
        console.log('a test')
         alasql('SELECT * INTO XLSX("mydata.xlsx",{headers:true}) FROM ?',[$scope.testItems]);
      };
      $scope.testItems = [{a:1,b:10},{a:2,b:20},{a:3,b:30}];`
    `$scope.getBatchStatus = function(batchId) {
      var status = '';
      $scope.clearance_batches.forEach(function(batch) {
          if (batchId == batch.id) {
            batch.submitted ? status = 'Submitted' : status = 'In Progress';
          }
        });
        return status;
      }`

    `$scope.itemsInBatch = function(batchId) {
      var itemsInBatch = []
      $scope.items.forEach(function(item) {
          if (batchId == item.clearance_batch_id) {
            itemsInBatch.push(item);
          }
        });
        return itemsInBatch;
      }`

    `$scope.submitBatch = function(batchId) {
      $scope.entry = ClearanceBatch.get({ id: batchId }, function() {
        $scope.entry.submitted = 'true';
        $scope.entry.$update(function(data) {
          $scope.getBatchStatus;
        },function(error) {
          console.log(error)
          });
      });
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
