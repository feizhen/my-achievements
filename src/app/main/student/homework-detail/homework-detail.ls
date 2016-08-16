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

          distribution: (auth-service, achievements-service, $state-params) ->
            homework-id = +$state-params.id || 1
            class-id = auth-service.get-user!.class
            achievements-service.get-distribution class-id, homework-id

        views:
          'content@app':
            template-url: 'app/main/student/homework-detail/homework-detail.html'
            controller-as: 'vm'

            controller: ($scope, $state-params, auth-service, homeworks, distribution) !->

              vm = @
              vm.user = auth-service.get-user!
              vm.homeworks = homeworks
              vm.current = $state-params.id
              vm.class-id = vm.user.class
              vm.distribution = distribution

      }
