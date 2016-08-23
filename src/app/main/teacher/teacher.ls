'use strict'

angular
  .module 'app.teacher', ['app.teacher.homework-list']
  .config teacher-config

  teacher-config.$inject = ['$stateProvider']

  !function teacher-config ($state-provider)
    $state-provider
      .state 'app.teacher', {
        abstract: true
        data:
          role: 'teacher'
      }
