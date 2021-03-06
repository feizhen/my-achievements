'use strict'
angular
  .module 'app.auth.login', []
  .config Auth-login-config

  Auth-login-config.$inject = [ '$stateProvider' ]
  
  !function Auth-login-config ( $state-provider )

    $state-provider
      .state 'app.auth.login', {
        url: '/login'
        body-class: 'login'
        views:
          'main@':
            template-url: 'app/core/layouts/content-only.html'
            controller: 'MainController as vm'

          'content@app.auth.login':
            template-url: 'app/main/auth/login/login.html'
            controller-as: 'vm'
            controller: ( auth-service, $state, $scope ) ->

              auth = auth-service
              vm = @

              login: ->
                auth.login @form .then (user) ->
                  if user
                    vm.invalid-user = false
                    dest = auth.get-dest!
                    $state.go dest
                  else
                    vm.invalid-user = true
      }
