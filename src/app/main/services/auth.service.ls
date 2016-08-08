'use strict'

angular
  .module 'fuse'
  .factory 'authService', authService

  authService.$inject = ['$resource', '$rootScope', '$cookies', 'apiResolver']

  !function authService ($resource, $root-scope, $cookies, api-resolver)
    current-user = null
    service =
      login: login

    return service

    !function login (params)
      filter =
        "where":
          "username": params.username
          "password": md5 params.password

      return api-resolver.resolve 'lb_users@query', { "filter": filter }
              .then (user) ->
                if user.length
                  current-user := user[0]
                  $root-scope.current-user = current-user
                  $cookies.put-object 'cookieUser', current-user
                  return Promise.resolve current-user
                Promise.resolve current-user
