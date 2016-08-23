'use strict'

angular
	.module 'app.auth.profile', []
	.config Auth-profile-config

	Auth-profile-config.$inject = [ '$stateProvider' ]

	!function Auth-profile-config ( $state-provider )
		$state-provider
			.state 'app.auth.profile', {
				url: '/profile'
				resolve:
					user: (auth-service) ->
						auth-service.get-user!
				views:
					'content@app':
						template-url: 'app/main/auth/profile/profile.html'
						controller-as: 'vm'
						controller: (user, auth-service, $md-dialog) !->
							vm = @
							vm.user = user	
							if user.role is 'student'
								vm.members = []
								auth-service.get-group-members  +user.class, +user.group .then (users) !->
									for member in users
										if member.username != vm.user.username
											vm.members.push(member)

							vm.modifyInformation = ($event)!->
								$md-dialog.show {
									template-url: 'app/main/auth/profile/dialog/dialog.html'
									click-outside-to-close: true
									controller-as: 'dialog'
									controller: 'modifyInformation'
								}
			}