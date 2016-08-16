'use strict'

angular
  .module 'app.student.homework-detail', []
  .config Student-homework-detail-config

  Student-homework-detail-config.$inject = ['$stateProvider']

  !function Student-homework-detail-config ($state-provider)
    $state-provider
      .state 'app.student.homework-detail', {
        url: '/homework-detail/:id'
        resolve:
          homeworks: (auth-service, homework-service) ->
            user = auth-service.get-user!
            homework-service.get-homeworks-by-class-id user.class

        views:
          'content@app':
            template-url: 'app/main/student/homework-detail/homework-detail.html'
            controller-as: 'vm'

            controller: ($scope, $state-params, auth-service, homeworks) !->

              vm = @
              vm.user = auth-service.get-user!
              vm.homeworks = homeworks
              vm.current = $state-params.id || 1
              vm.class-id = vm.user.class

              vm.set-current-homework-id = (homework-id) !->
                vm.current = homework-id

      }
