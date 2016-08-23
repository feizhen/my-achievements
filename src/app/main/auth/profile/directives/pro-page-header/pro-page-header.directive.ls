'use strict'

angular
	.module 'app.auth.profile'
	.directive 'proPageHeader', Pro-page-header-directive

	!function Pro-page-header-directive
		directive =
			template-url: 'app/main/auth/profile/directives/pro-page-header/pro-page-header.html'
			restrict: 'EA'
			scope:
				user: '='
			controller-as: 'vm'
			controller: ($scope)!->
				vm = @
				vm.user = $scope.user

		return directive