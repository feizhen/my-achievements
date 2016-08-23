'use strict'

angular
  .module 'app.student', ['app.student.homework-dashboard', 'app.student.homework-detail', 'app.student.homework-review']
  .config student-config

  student-config.$inject = ['$stateProvider']

  !function student-config ($state-provider)
    $state-provider
      .state 'app.student', {
        abstract: true
        data:
          role: 'student'
      }
