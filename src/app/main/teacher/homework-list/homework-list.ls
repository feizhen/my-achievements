'use strict'

angular
  .module 'app.teacher.homework-list', []
  .config Teacher-homework-list-config

  Teacher-homework-list-config.$inject = ['$stateProvider']

  !function Teacher-homework-list-config ($state-provider)
    $state-provider
      .state 'app.teacher.homework-list', {
        url: '/homework-list'
        resolve:
            homeworks: (homework-service) ->
                homework-service.get-homeworks!
        views:
          'content@app':
            template-url: 'app/main/teacher/homework-list/homework-list.html'
            controller-as: 'vm'
            controller: ($scope, homeworks, auth-service) !->
              vm = @
              vm.user = auth-service.get-user!
              console.log homeworks
              vm.homeworks = homeworks
      }
