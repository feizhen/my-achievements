'use strict'

angular
  .module 'app.student.homework-dashboard', []
  .config Student-homework-dashboard-config

  Student-homework-dashboard-config.$inject = ['$stateProvider']

  !function Student-homework-dashboard-config ($state-provider)
    $state-provider
      .state 'app.student.homework-dashboard', {
        url: '/homework-dashboard'
        views:
          'content@app':
            template-url: 'app/main/student/homework-dashboard/homework-dashboard.html'
            controller-as: 'vm'
            controller: ($scope, $root-scope, auth-service) !->
              vm = @
              vm.user = auth-service.get-user!
      }
