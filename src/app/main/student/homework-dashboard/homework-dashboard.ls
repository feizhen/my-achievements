'use strict'

angular
  .module 'app.student.homework-dashboard', []
  .config Student-homework-dashboard-config

  Student-homework-dashboard-config.$inject = ['$stateProvider']

  !function Student-homework-dashboard-config ($state-provider)
    $state-provider
      .state 'app.student.homework-dashboard', {
        url: '/homework-dashboard'
        resolve:
          homeworks: (auth-service, homework-service) ->
            user = auth-service.get-user!
            homework-service.get-homeworks-by-class-id user.class

          scores: (auth-service, achievements-service) ->
            user = auth-service.get-user!
            achievements-service.get-user-scores user.username .then (data) -> data

        views:
          'content@app':
            template-url: 'app/main/student/homework-dashboard/homework-dashboard.html'
            controller-as: 'vm'
            controller: ($scope, auth-service, homeworks, scores) !->

              get-homework-ids = (homeworks) ->
                homework-ids = [homework.id for homework in homeworks]

              vm = @
              vm.user = auth-service.get-user!
              vm.scores = scores.join!
              vm.homeworkIds = get-homework-ids homeworks .join!

      }
