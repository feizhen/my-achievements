'user strict'
angular.module 'course', []

.config ($state-provider)-> $state-provider.state 'app.course', {abstract: true}

