'use strict'

angular
	.module 'fuse'
	.filter 'rolefilter', ->
		(input) ->
			output = input or ''
			switch	input
			case 'teacher' then '教师'
			case 'student' then '学生'
			case 'ta' 	   then '助教'
			default ''