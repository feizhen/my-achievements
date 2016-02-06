'use strict'
angular.module 'app.auth.login', []

.config ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)->
  $translate-partial-loader-provider.add-part 'app/main/auth/login'

  $state-provider.state 'app.login', { 
    url               : '/login'
    body-class        : 'login'
    views             :   
      'main@'         :   
        template-url  : 'app/core/layouts/content-only.html'
        controller    : 'MainController as vm'

      'content@app.login'  :  
        template-url            : 'app/main/auth/login/login.html'
        controller-as           : 'vm'
        controller              : ($scope, $root-scope, authService, $state)->
          login: -> authService.auth @form .then (result)~> 
            console.log "user with email: #{@form.email} is registed? ", result.is-registed
            if result.is-registed 
              @invalid-user = false
              $state.go 'app.sample'
            else
              @invalid-user = true
  }

.factory 'authService',  (api)-> 
  service = 
    current-user: null
    auth: ({email, password})-> api.auth.is-registed-user {email, password} .then (result)->
      service.current-user = result.user if result.is-registed
      result

.run ($root-scope, $state, authService)!->
  $root-scope.$on '$stateChangeStart', (event, to-state)!->
    return if !!authService.current-user or to-state.name is 'app.login'

    event.prevent-default!
    $state.go 'app.login'

  $root-scope.$on '$logout', (event)!->
    authService.current-user = null
    $state.go 'app.login'
