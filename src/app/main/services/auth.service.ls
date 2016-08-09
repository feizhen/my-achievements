'use strict'

angular
  .module 'fuse'
  .factory 'authService', authService

  authService.$inject = ['$resource', '$rootScope', '$cookies', 'apiResolver', '$state']

  !function authService ($resource, $root-scope, $cookies, api-resolver, $state)
    current-user = null
    service =
      login: login
      logout: logout
      get-user: get-user
      is-logged-in: is-logged-in
      get-user-from-cookie: get-user-from-cookie

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
                  $cookies.put-object 'cookieUser', current-user
                  return Promise.resolve current-user
                Promise.resolve current-user

    !function logout
      current-user := null
      $cookies.remove 'cookieUser'

    !function is-logged-in
      return current-user != null

    !function get-user
      return current-user

    !function get-user-from-cookie
      current-user := $cookies.get-object 'cookieUser' || null
      return Promise.resolve current-user
