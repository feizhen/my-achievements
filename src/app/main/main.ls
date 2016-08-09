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

    if user
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
        title: '退出登录'
        icon: 'icon-login'
        event: !->
          auth.logout!
      }

    $scope.$on '$viewContentAnimationEnded', (event) -> $root-scope.$broadcast 'msSplashScreen::remove' if event.target-scope.$id is $scope.$id
    state-change-listener-stop = $root-scope.$on '$stateChangeStart', (event, to-state, from-state)!->
    $root-scope.$on 'destroy', !-> state-change-listener-stop!
