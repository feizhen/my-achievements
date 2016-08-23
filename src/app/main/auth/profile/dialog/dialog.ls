'use strict'

angular
	.module 'app.auth.profile'
	.controller 'modifyInformation', ModifyInformation

	ModifyInformation.$inject = ['authService', '$mdDialog']

	!function ModifyInformation (auth-service, $md-dialog)
		auth = auth-service
		user = auth.get-user!
		dialog = @
		dialog.user = user
		dialog.flag = true
		dialog.info =
			avatar: user.avatar
			fullname: user.fullname
			sid: user.sid
			email: user.email

		dialog.change-password = !->
			dialog.flag = !dialog.flag

		dialog.close-dialog = !->
			$md-dialog.hide!