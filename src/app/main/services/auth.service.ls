'use strict'

angular
  .module 'fuse'
  .factory 'authService', authService

  authService.$inject = ['$resource', '$cookies', '$state', 'apiResolver']

  !function authService ($resource, $cookies, $state, api-resolver)
    current-user = null
    service =
      login: login
      logout: logout
      get-user: get-user
      get-dest: get-dest
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
      console.log '退出登录'
      current-user := null
      $cookies.remove 'cookieUser'
      $state.go 'app.auth.login'

    !function is-logged-in
      return current-user != null

    !function get-user
      return current-user

    !function get-dest
      role = current-user && current-user.role
      if role
        switch role
        | 'student' => return 'app.student.homework-dashboard'
        | 'teacher' => return 'app.student.homework-dashboard'
        | otherwise => return 'app.auth.login'
      else
        return 'app.auth.login'

    !function get-user-from-cookie
      current-user := $cookies.get-object 'cookieUser' || null
      return Promise.resolve current-user
