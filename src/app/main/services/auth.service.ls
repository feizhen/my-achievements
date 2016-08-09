'use strict'

angular
  .module 'fuse'
  .factory 'authService', authService

  authService.$inject = ['$resource', '$cookies', '$state', 'apiResolver']

  !function authService ($resource, $cookies, $state, api-resolver)
    current-user = null
    service =
      login:                login
      logout:               logout
      is-logged-in:         is-logged-in
      is-student:           is-student
      is-teacher:           is-teacher
      is-ta:                is-ta
      is-admin:             is-admin
      get-user:             get-user
      get-dest:             get-dest
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

    !function get-dest
      role = current-user && current-user.role
      if role
        switch role
        | 'student' => return 'app.student.homework-dashboard'
        | 'teacher' => return 'app.teacher.homework-list'
        | otherwise => return 'app.auth.login'
      else
        return 'app.auth.login'

    !function get-user-from-cookie
      current-user := $cookies.get-object 'cookieUser' || null
      return Promise.resolve current-user

    !function is-logged-in
      return current-user != null

    !function get-user
      return current-user

    !function is-student
      return current-user.role is 'student'

    !function is-teacher
      return current-user.role is 'teacher'

    !function is-admin
      return current-user.role is 'admin'

    !function is-ta
      return current-user.role is 'ta'
