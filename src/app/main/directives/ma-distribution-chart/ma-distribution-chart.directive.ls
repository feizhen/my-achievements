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

      controller-as: 'vm'
      controller: ($scope, achievements-service) !->

        achi = achievements-service
        vm = @

        #chart config
        vm.chart-config = {
          config:
            refreshDataOnly: true
            deep-watch-data  : true

          options:
            chart:
              type: 'pieChart',
              color: ['#607D8B', '#9c27b0','#03a9f4','#e91e63','#f44336']
              height: 360
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
              x : (d)->
                d.label
              y : (d)->
                return d.value
              tooltip     :
                gravity: 's'
                classes: 'gravity-s'
          data: []
        }

        #定义数据
        vm.fail = 0
        vm.sixty-to-seventy = 0
        vm.seventy-to-eighty = 0
        vm.eighty-to-ninety = 0
        vm.ninety-to-full = 0

        vm.current-homework-id = +$scope.current
        vm.class-id = +$scope.class
        vm.set-distribution = (homework-id) !->
          achi.get-distribution vm.class-id, homework-id .then (data) !->
            set-chart-data data

        $scope.$watch 'current', !->
          #这里有坑，$scope.current 会被当做string传入,要转成number才能取到数据
          vm.current-homework-id = +$scope.current
          vm.set-distribution vm.current-homework-id

        !function set-chart-data (data)

          vm.fail := data[0]
          vm.sixty-to-seventy := data[1]
          vm.seventy-to-eighty := data[2]
          vm.eighty-to-ninety := data[3]
          vm.ninety-to-full := data[4]

          vm.chart-config.data = [
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

    return directive
