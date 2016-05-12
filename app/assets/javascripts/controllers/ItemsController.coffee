controllers = angular.module 'controllers', ['itemService','batchService','typeService']

controllers.controller("ItemsController", [ '$scope', '$routeParams', '$location', '$resource', '$timeout', 'Item','ClearanceBatch','Type'
  ($scope,$routeParams,$location,$resource,$timeout,Item,ClearanceBatch,Type)->

    $scope.pageStatus = {}

    getData = ->
      $scope.pageStatus.loading = true
      $scope.clearance_batches = ClearanceBatch.all {}, () ->
      $scope.types = Type.all {}, () ->
      Item.all {}, (data) ->
        $scope.items = data
        $scope.pageStatus.loading = false
      return

    getData()

    $scope.alert = ''

    setAlert = (alert) ->

    $scope.goToBatch = (batchId) ->
      batch = '/' + batchId
      $location.path batch
      return

    $scope.updateMinPrice = (id, min_price) ->
      $scope.type = Type.get({ id: id }, ->
        $scope.type.min_price = min_price
        $scope.type.$update ((data) ->
          return
        ), (error) ->

          return
        return
      )
      return

    $scope.sortGroup = (key) ->
      $scope.sortSelect = key
      return

    $scope.createNewBatch = ->
      $scope.entry = ClearanceBatch.create((data) ->
        batch = '/' + data.id
        $location.path batch
        return
      )
      return

    $scope.clearanceItem = (scopeId, batchId) ->
      batch = batchId.choice
      $scope.entry = Item.get({ id: scopeId }, ->
        $scope.entry.clearance_batch_id = batch
        $scope.entry.$update ((data) ->
          $scope.updateItem(data, scopeId)
          $scope.toaster('Item ' + data.id + ' was added to Batch ' + batch + '.')
          return
        ), (error) ->
          $scope.toaster('Item could not be clearanced.',true)
          return
        return
      )
      return

    $scope.updateItem = (data, id) ->
      angular.forEach $scope.items, (item, index) ->
        if +id is item.id
          scopeItem = $scope.items.indexOf(item)
          $scope.items[scopeItem] = data
        return


    $scope.changeView = (batchId) ->
      batch = '/' + batchId
      $location.path batchId
      return

      $scope.showError = false
      $scope.showSuccess = false
      $scope.doFade = false

    $scope.toaster = (message,error) ->
      #reset
      if error
        $scope.showSuccess = false
        $scope.showError = false
        $scope.doFade = false
        $scope.showError = true
        $scope.errorMessage = message
      else
        $scope.showError = false
        $scope.showSuccess = false
        $scope.doFade = false
        $scope.showSuccess = true
        $scope.successMessage = message
      $timeout (->
        $scope.doFade = true
        return
      ), 2500
      return
])

controllers.controller("BatchController", [ '$scope', '$routeParams', '$location', '$timeout','$resource', 'Item','ClearanceBatch'
  ($scope,$routeParams,$location,$timeout,$resource,Item,ClearanceBatch)->

    $scope.pageStatus = {}
    $scope.batchId = $routeParams.id

    getData = ->
      $scope.pageStatus.loading = true
      ClearanceBatch.all {}, (data) ->
        $scope.clearance_batches = data
        Item.all {}, (data) ->
          $scope.items = data
          getBatchStatus($scope.batchId)
          $scope.pageStatus.loading = false
          return
      return

    getData()

    getBatchStatus = (batchId) ->
      status = ''
      $scope.clearance_batches.forEach (batch) ->
        if +batchId is batch.id
          if batch.submitted then ($scope.batchStatus = 'Submitted') else ($scope.batchStatus = 'In Progress')
        return

    $scope.clearanceItem = (scopeId, batchId) ->
      $scope.entry = Item.get({ id: scopeId }, ->
        if alreadyClearanced($scope.entry)
          return
        $scope.entry.clearance_batch_id = batchId
        $scope.entry.$update ((data) ->
          $scope.toaster('Item ' + data.id + ' was added to Batch ' + batchId + '.')
          $scope.items[scopeId - 1] = data
          return
        ), (error) ->
          $scope.toaster('Item ' + $scope.entry.id + ' was clearanced.')
          return
        return
      )
      return

    alreadyClearanced = (item) ->
        if (item.clearance_batch_id)
          $scope.toaster('Item ' + $scope.entry.id + ' has already been clearanced.',true)
          true

    $scope.exportData = ->
      alasql 'SELECT * INTO XLSX("mydata.xlsx",{headers:true}) FROM ?', [ $scope.testItems ]
      return

    $scope.itemsInBatch = (batchId) ->
      itemsInBatch = []
      $scope.items.forEach (item) ->
        if +batchId == item.clearance_batch_id
          itemsInBatch.push item
        return
      itemsInBatch

    $scope.submitBatch = (batchId) ->
      $scope.entry = ClearanceBatch.get({ id: batchId }, ->
        $scope.entry.submitted = 'true'
        $scope.entry.$update ((data) ->
          $scope.clearance_batches[+batchId - 1] = data
          getBatchStatus(batchId)
          $scope.toaster('Batch ' + batchId + ' was submitted.')
          return
        ), (error) ->
          $scope.toaster('Batch could not be submitted.',true)
          return
        return
      )
      return

    $scope.sortGroup = (key) ->
      $scope.sortSelect = key
      return

    $scope.unClearanceItem = (scopeId) ->
      $scope.entry = Item.get({ id: scopeId }, ->
        $scope.entry.$update ((data) ->
          $scope.entry = Item.get({ id: scopeId }, ->
            $scope.updateItem($scope.entry,scopeId)
            $scope.toaster('Item ' + $scope.entry.id + ' was removed from Batch '+ $scope.batchId + '.')
            return
          )
          return
        ), (xhr) ->
          $scope.toaster('Item' + $scope.entry.id + ' could not be unclearanced.')
          return
        return
      )
      return

    $scope.updateItem = (data, id) ->
      angular.forEach $scope.items, (item, index) ->
        if +id is item.id
          scopeItem = $scope.items.indexOf(item)
          $scope.items[scopeItem] = data
        return

    $scope.goToIndex = ->
      batch = '/'
      $location.path batch
      return

      $scope.showError = false
      $scope.showSuccess = false
      $scope.doFade = false

    $scope.toaster = (message,error) ->
      #reset
      if error
        $scope.showSuccess = false
        $scope.showError = false
        $scope.doFade = false
        $scope.showError = true
        $scope.errorMessage = message
      else
        $scope.showError = false
        $scope.showSuccess = false
        $scope.doFade = false
        $scope.showSuccess = true
        $scope.successMessage = message
      $timeout (->
        $scope.doFade = true
        return
      ), 2000
      return
])
