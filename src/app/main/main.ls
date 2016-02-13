'use strict'
angular.module 'fuse' 

.config navigations = ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)!->
  'ngInject'
  nav = ms-navigation-service-provider

  # -------- 功能分组 -------- #
  angular.module 'course', [] .config ($state-provider)-> $state-provider.state 'app.course', abstract: true



  # --------- 菜单 ----------- #
  nav.save-item 'course',          {title : '课程'      , group : true,  weight: 1 }

  nav.save-item 'course.dashboard',  {title : '作业概览'   , icon  : 'icon-chart-line',   state : 'app.course.dashboard',    weight   : 1 }

  nav.save-item 'course.problems',  {title : '题库管理'   , icon  : 'icon-folder-multiple-outline',   state : 'app.course.problems',    weight   : 1 }

  nav.save-item 'class',          {title : '班级'      , group : true,  weight: 1 }

  nav.save-item 'class.dashboard',  {title : '班级概览'   , icon  : 'icon-chart-line',   state : 'app.class.dashboard',    weight   : 1 }

  nav.save-item 'class.management',  {title : '班级管理'   , icon  : 'icon-account-multiple',   state : 'app.class.management',    weight   : 1 }



.controller 'MainController', ($scope, $root-scope, ms-navigation-service, $state)!->
  'ngInject'
  # Remove the splash screen
  $scope.$on '$viewContentAnimationEnded', (event)-> $root-scope.$broadcast 'msSplashScreen::remove' if event.target-scope.$id is $scope.$id

  state-change-listener-stop = $root-scope.$on '$stateChangeStart', (event, to-state, from-state)!->
    nav = ms-navigation-service
    if $root-scope.current-user? and 'admin' in $root-scope.current-user.roles
      nav.save-item 'admin',        {title : '系统管理'   , group : true,  weight: 1 }
      nav.save-item 'admin.schools',  {title : '学校管理'   , icon  : 'icon-school',   state : 'app.admin.schools',    weight   : 1 }
      nav.save-item 'admin.problems',  {title : '题库管理'   , icon  : 'icon-folder-multiple-outline',   state : 'app.admin.problems',    weight   : 1 }
    else
      nav.delete-item 'admin'
      nav.delete-item 'admin.schools'
      nav.delete-item 'admin.problems'

  $root-scope.$on 'destroy', !-> state-change-listener-stop!
