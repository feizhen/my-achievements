'use strict'

angular
  .module 'fuse'
  .factory 'homeworkService', HomeworkService

  HomeworkService.$inject = ['apiResolver']

  !function HomeworkService (api-resolver)
    service =
      get-homeworks: get-homeworks
      get-homeworks-by-class-id: get-homeworks-by-class-id

    return service

    !function get-homeworks
      return api-resolver.resolve 'lb_homeworks@query' .then (result) ->
              result

    !function get-homeworks-by-class-id (class-id)
      return api-resolver.resolve 'lb_homeworks@query' .then (result) ->
              homeworks = []
              for i from 0 til result.length-1
                _class = _.remove result[i].classes, (c) -> c.class_id is class-id
                homeworks.push {
                  id: result[i].id
                  title: result[i].title
                  description: result[i].description
                  class: _class[0]
                }
              Promise.resolve homeworks
