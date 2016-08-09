'use strict'

angular
  .module 'app.student', ['app.student.homework-dashboard', 'app.student.homework-detail']
  .config student-config

  student-config.$inject = ['$stateProvider']

  !function student-config ($state-provider)
    $state-provider
      .state 'app.student', {
        abstract: true
        role: 'student'
      }
