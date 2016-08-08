'use strict'
angular.module 'fuse'

.controller 'MainController', ($scope, $root-scope, ms-navigation-service, $state)!->
  'ngInject'
  # Remove the splash screen
  $scope.$on '$viewContentAnimationEnded', (event)-> $root-scope.$broadcast 'msSplashScreen::remove' if event.target-scope.$id is $scope.$id

  state-change-listener-stop = $root-scope.$on '$stateChangeStart', (event, to-state, from-state)!->

  $root-scope.$on 'destroy', !-> state-change-listener-stop!
