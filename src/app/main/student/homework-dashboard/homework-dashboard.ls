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

          ranks: (auth-service, achievements-service) ->
            user = auth-service.get-user!
            achievements-service.get-user-ranks user.username, user.class

        views:
          'content@app':
            template-url: 'app/main/student/homework-dashboard/homework-dashboard.html'
            controller-as: 'vm'
            controller: ($scope, auth-service, homeworks, scores, ranks) !->

              get-homework-ids = (homeworks) ->
                homework-ids = [homework.homework-id for homework in homeworks]

              arr2string = (arr) -> arr.join!

              vm = @
              vm.user = auth-service.get-user!
              vm.homeworks = homeworks
              vm._scores = scores
              console.log vm._scores
              vm.scores = arr2string vm._scores
              vm._ranks = ranks
              console.log vm._ranks
              vm.ranks = arr2string vm._ranks
              vm.homework-ids = arr2string get-homework-ids homeworks
              vm.switch =
                future:  true
                present: true
                finish:  true

      }
