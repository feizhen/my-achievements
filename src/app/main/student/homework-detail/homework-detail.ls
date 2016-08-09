'use strict'

angular
  .module 'app.student.homework-detail', []
  .config Student-homework-detail-config

  Student-homework-detail-config.$inject = ['$stateProvider']

  !function Student-homework-detail-config ($state-provider)
    $state-provider
      .state 'app.student.homework-detail', {
        url: '/homework-detail'
        views:
          'content@app':
            template-url: 'app/main/student/homework-detail/homework-detail.html'
            controller-as: 'vm'
            controller: ($scope, $root-scope, auth-service) !->
              vm = @
              vm.user = auth-service.get-user!
      }
