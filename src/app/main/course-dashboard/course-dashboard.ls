'use strict'
angular.module 'app.course.dashboard', ['course']
  
.config ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)!->
  'ngInject'
  
  $state-provider.state 'app.course.dashboard', {
    url: '/course/dashboard'
    views:
      'content@app':
        template-url: 'app/main/course-dashboard/course-dashboard.html'
        controller: ($scope)!->
          $scope.hello-text = '课程列表，待开发。。。'
  }
