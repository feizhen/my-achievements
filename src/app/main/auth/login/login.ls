'use strict'
angular
  .module 'app.auth.login', []
  .config Auth-login-config

  Auth-login-config.$inject = [ '$stateProvider', 'msNavigationServiceProvider' ]
  !function Auth-login-config ( $state-provider, ms-navigation-service-provider )

    $state-provider.state 'app.auth.login', {
      url: '/login'
      body-class: 'login'
      views:
        'main@':
          template-url: 'app/core/layouts/content-only.html'
          controller: 'MainController as vm'

        'content@app.auth.login':
          template-url: 'app/main/auth/login/login.html'
          controller-as: 'vm'
          controller: ( auth-service, $state, $scope, $root-scope ) ->

            auth = auth-service

            login: ->
              auth.login @form .then (user) ->
                if user
                  dest = auth.get-dest!
                  $state.go dest
    }
