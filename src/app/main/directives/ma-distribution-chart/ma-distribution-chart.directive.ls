'use strict'

angular
  .module 'fuse'
  .directive 'maDistributionChart', maDistributionChart

  !function maDistributionChart
    directive =
      template-url: 'app/main/directives/ma-distribution-chart/ma-distribution-chart.html'
      restrict: 'EA'
      scope:
        current: '='
        class: '='
        distribution: '='

      controller-as: 'vm'
      controller: ($scope, achievements-service) !->
        achi = achievements-service

        vm = @
        vm.current-homework-id = +$scope.current || 1
        vm.class-id = +$scope.class
        vm.distribution = $scope.distribution
        vm.get-distribution = get-distribution

        #data
        vm.fail = vm.distribution[0]
        vm.sixty-to-seventy = vm.distribution[1]
        vm.seventy-to-eighty = vm.distribution[2]
        vm.eighty-to-ninety = vm.distribution[3]
        vm.ninety-to-full = vm.distribution[4]

        !function get-distribution
          achi.get-distribution vm.class-id, vm.current-homework-id .then(result) !->
            vm.distribution := result

        vm.chart-config = {
          config:
            refreshDataOnly: true
            deep-watch-data  : true

          options:
            chart:
              type: 'pieChart',
              color: ['#607D8B', '#9c27b0','#03a9f4','#e91e63','#f44336']
              height: 400
              margin:
                top   : 0
                bottom: 0
                left  : 0
                right : 0
              donut       : true
              clipEdge    : true
              cornerRadius: 0
              labelType   : 'percent'
              padAngle    : 0.02
              x :  (d)->
                d.label
              y : (d)->
                return d.value
              tooltip     :
                gravity: 's'
                classes: 'gravity-s'

          data: [
            {
              label: '<60'
              value: vm.fail
            },
            {
              label: '60~70'
              value: vm.sixty-to-seventy
            },
            {
              label: '70~80'
              value: vm.seventy-to-eighty
            },
            {
              label: '80~90'
              value: vm.eighty-to-ninety
            },
            {
              label: '90~100'
              value: vm.ninety-to-full
            }
          ]
        }

    return directive
