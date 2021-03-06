'use strict'

angular
  .module 'fuse'
  .directive 'maRankTable', ma-rank-table
  .filter 'startFrom', start-from

  !function ma-rank-table
    directive =
      template-url: 'app/main/directives/ma-rank-table/ma-rank-table.html'
      restrict: 'EA'
      scope:

        homeworks: '='
        current: '='
        class: '='
        outside-fn: '&onPageChange'

      controller-as: 'vm'
      controller: ($scope, achievements-service, pagination-service) !->

        get-homework-ids = (homeworks) ->
          homework-ids = [homework.homework-id for homework in homeworks]

        achi = achievements-service
        pa = pagination-service

        vm = @
        vm.class = +$scope.class
        vm.homeworks = $scope.homeworks
        vm.homework-ids = get-homework-ids $scope.homeworks
        vm.current-homework-id = +$scope.current || 1
        vm.pagination = pa.get-new!
        vm.get-rank-list = get-rank-list

        vm.get-rank-list!

        !function get-rank-list (homework-id)
          if $scope.outside-fn and homework-id
            $scope.outside-fn {homework-id: homework-id}
          return achi.get-rank-list vm.class, vm.current-homework-id .then (result) ->
            vm.pagination.current-page := 0
            vm.rank-list = result
            vm.pagination.num-of-pages := Math.ceil result.length / vm.pagination.page-size

    return directive

  !function start-from
    return
      (input, start)->
        if (input === undefined)
          return input
        else
          return input.slice +start
