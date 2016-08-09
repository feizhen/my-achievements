'use strict'
angular
  .module 'fuse'
  .controller 'MainController', MainController

  MainController.$inject = ['$scope', '$rootScope', '$state', 'msNavigationService', 'authService']

  !function MainController ($scope, $root-scope, $state, ms-navigation-service, auth-service)
    'ngInject'

    nav = ms-navigation-service
    auth = auth-service
    user = auth.get-user!


    !function set-user-items
      nav.save-item 'user', {
        title: '用户'
        group: true
        weight: 2
        class: 'user'
      }
      nav.save-item 'user.profile', {
        title: " #{user.fullname}, 您好!"
        image: user.avatar
        state: 'app.auth.profile'
      }
      nav.save-item 'user.logout', {
        title: '退出'
        icon: 'icon-login'
        event: -> auth.logout!
      }

    !function set-student-items
      nav.save-item 'student', {
        title: '作业'
        weight: 1
        group: true
        hidden: -> !auth.is-student!
      }
      nav.save-item 'student.homework-dashboard', {
        title: '作业概览'
        weight: 1
        group: false
        state: 'app.student.homework-dashboard'
        icon: 'icon-chart-line'
        hidden: -> !auth.is-student!
      }
      nav.save-item 'student.homework-detail', {
        title: '作业详情'
        weight: 1
        group: false
        state: 'app.student.homework-detail'
        icon: 'icon-border-color'
        hidden: -> !auth.is-student!
      }

    !function set-teacher-items
      nav.save-item 'teacher', {
        title: '作业'
        weight: 1
        group: true
        hidden: -> !auth.is-teacher!
      }
      nav.save-item 'teacher.homework-list', {
        title: '作业列表'
        weight: 1
        group: false
        state: 'app.teacher.homework-list'
        icon: 'icon-chart-line'
        hidden: -> !auth.is-teacher!
      }

    if user
      set-user-items!
      set-student-items!
      set-teacher-items!



    $scope.$on '$viewContentAnimationEnded', (event) -> $root-scope.$broadcast 'msSplashScreen::remove' if event.target-scope.$id is $scope.$id

    state-change-listener-stop = $root-scope.$on '$stateChangeStart', (event, to-state, from-state)!->

    $root-scope.$on 'destroy', !-> state-change-listener-stop!
