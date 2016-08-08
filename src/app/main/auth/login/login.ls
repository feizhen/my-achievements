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
        controller              : ( auth-service, $state, $scope )->
          login: ->
            auth-service.login @form .then (user) ->
              if user
                $state.go 'app.student.homework-dashboard'
  }
