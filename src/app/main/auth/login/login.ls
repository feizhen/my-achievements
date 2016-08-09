'use strict'
angular.module 'app.auth.login', []

.config ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)->
  $translate-partial-loader-provider.add-part 'app/main/auth/login'

  $state-provider.state 'app.auth.login', {
    url               : '/login'
    body-class        : 'login'
    views             :
      'main@'         :
        template-url  : 'app/core/layouts/content-only.html'
        controller    : 'MainController as vm'

      'content@app.auth.login'  :
        template-url            : 'app/main/auth/login/login.html'
        controller-as           : 'vm'
        controller              : ( auth-service, $state, $scope, $root-scope ) ->

          auth = auth-service
          user = auth.get-user!

          # 判断是否是退出登录的操作
          !function _is-logout (from-state)
            from-state-path = from-state.name
            ancestor-paths = from-state-path.split '.'
            return ancestor-paths and ancestor-paths[0] is 'app' and from-state-path isnt 'app.login'

          $scope.$on '$stateChangeSuccess', (event, to-state, to-params, from-state)!->
            is-logout = _is-logout from-state
            if is-logout
              console.log "退出登录"
              auth.logout!

          login: ->
            auth.login @form .then (user) ->
              if user
                $state.go 'app.student.homework-dashboard'
  }
