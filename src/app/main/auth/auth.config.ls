'use strict'

angular
  .module 'app.auth', ['app.auth.login']
  .config Auth-config

  Auth-config.$inject = ['$stateProvider']

  !function Auth-config ($state-provider)
    $state-provider
      .state 'app.auth', {
        abstract: true
      }
