'use strict'

angular
  .module 'app.student', ['app.student.homework-dashboard', 'app.student.homework-detail']
  .config student-config

  student-config.$inject = ['$stateProvider', 'msNavigationServiceProvider']

  !function student-config ($state-provider, ms-navigation-service-provider)
    $state-provider
      .state 'app.student', {
        abstract: true
        role: 'student'
      }
