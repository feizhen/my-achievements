'use strict'

angular
  .module 'app.student', ['app.student.homework-dashboard']
  .config Student-config

  Student-config.$inject = ['$stateProvider']

  !function Student-config ($state-provider)
    $state-provider
      .state 'app.student', {
        abstract: true
        data:
          role: 'student'
      }
