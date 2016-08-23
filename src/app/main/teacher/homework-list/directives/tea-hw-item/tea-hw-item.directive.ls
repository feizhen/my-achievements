'use strict'

angular
    .module 'app.teacher.homework-list'
    .directive 'teaHwItem', ->
        tea-hw-item = {
            template-url: 'app/main/teacher/homework-list/directives/tea-hw-item/tea-hw-item.html'
            restrict: 'EA'
            scope:
                homework: '='
            controller-as: 'vm'
            controller: ->
                console.log 'directive'
        }
