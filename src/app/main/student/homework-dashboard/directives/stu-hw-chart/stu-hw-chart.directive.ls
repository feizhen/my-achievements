'use strict'

angular
  .module 'app.student.homework-dashboard'
  .directive 'stuHwChart', ->
    stu-hw-chart = {
      template-url: '/app/main/student/homework-dashboard/directives/stu-hw-chart/stu-hw-chart.html'
      restrict: 'E'
      scope:
        data: '='
        ids: '='
        type: '@'
      controller: ($scope) !->
        $scope.tick-format = (d) ->
          if d ~= 0 then 1 else d
    }
