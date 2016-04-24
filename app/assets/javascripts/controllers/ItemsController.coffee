
controllers = angular.module 'controllers', ['itemService','batchService','styleService','typeService']

controllers.controller("ItemsController", [ '$scope', '$routeParams', '$location', '$resource', 'Item','ClearanceBatch','Style','Type'
  ($scope,$routeParams,$location,$resource,Item,ClearanceBatch,Style,Type)->

    $scope.items = Item.all {}, () -> console.log($scope.items)
    $scope.clearance_batches = ClearanceBatch.all {}, () -> console.log($scope.clearance_batches)
    $scope.types = Type.all {}, () -> console.log($scope.types)

    $scope.updateMinPrice = (id, min_price) ->
      $scope.type = Type.get({ id: id }, ->
        $scope.type.min_price = min_price
        $scope.type.$update ((data) ->
          console.log 'success'
          console.log data
          return
        ), (error) ->
          console.log error
          return
        return
      )
      console.log id + ' - ' + min_price
      return

    $scope.sortGroup = (key) ->
      $scope.sortSelect = key
      return

    $scope.createNewBatch = ->
      $scope.entry = ClearanceBatch.create((data) ->
        console.log data
        batch = '/' + data.id
        $location.path batch
        return
      )
      return

    $scope.clearanceItem = (scopeId, batchId) ->
      $scope.entry = Item.get({ id: scopeId }, ->
        $scope.entry.clearance_batch_id = batchId
        $scope.entry.$update ((data) ->
          $scope.entry = Item.get({ id: scopeId }, ->
            $scope.items[scopeId - 1] = $scope.entry
            return
          )
          return
        ), (error) ->
          console.log error
          return
        return
      )
      return

    $scope.changeView = (batchId) ->
      batch = '/' + batchId
      $location.path batchId
      return
])


controllers.controller("BatchController", [ '$scope', '$routeParams', '$location', '$resource', 'Item','ClearanceBatch'
  ($scope,$routeParams,$location,$resource,Item,ClearanceBatch)->

    $scope.items = Item.all {}, () -> console.log($scope.items)
    $scope.clearance_batches = ClearanceBatch.all {}, () -> console.log($scope.clearance_batches)

    $scope.exportData = ->
      console.log 'a test'
      alasql 'SELECT * INTO XLSX("mydata.xlsx",{headers:true}) FROM ?', [ $scope.testItems ]
      return

    $scope.getBatchStatus = (batchId) ->
      status = ''
      $scope.clearance_batches.forEach (batch) ->
        if parseInt(batchId) is batch.id
          console.log 'this is working'
          if batch.submitted then (status = 'Submitted') else (status = 'In Progress')
        return
      status

    $scope.itemsInBatch = (batchId) ->
      itemsInBatch = []
      $scope.items.forEach (item) ->
        if parseInt(batchId) == item.clearance_batch_id
          itemsInBatch.push item
        return
      itemsInBatch

    $scope.submitBatch = (batchId) ->
      $scope.entry = ClearanceBatch.get({ id: batchId }, ->
        $scope.entry.submitted = 'true'
        $scope.entry.$update ((data) ->
          $scope.getBatchStatus
          return
        ), (error) ->
          console.log error
          return
        return
      )
      return

    $scope.sortGroup = (key) ->
      $scope.sortSelect = key
      return

    $scope.batchId = $routeParams.id

    $scope.unClearanceItem = (scopeId) ->
      $scope.entry = Item.get({ id: scopeId }, ->
        $scope.entry.$update ((data) ->
          $scope.entry = Item.get({ id: scopeId }, ->
            $scope.items[scopeId - 1] = $scope.entry
            return
          )
          return
        ), (error) ->
          console.log error
          return
        return
      )
      return

    $scope.goToIndex = ->
      batch = '/'
      $location.path batch
      return
])
