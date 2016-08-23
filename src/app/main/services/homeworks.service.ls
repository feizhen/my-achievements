'use strict'

angular
  .module 'fuse'
  .factory 'homeworkService', HomeworkService

  HomeworkService.$inject = ['apiResolver']

  !function HomeworkService (api-resolver)
    service =
      get-homeworks: get-homeworks
      get-homeworks-by-class-id: get-homeworks-by-class-id
      get-homework-by-class-and-homework-id: get-homework-by-class-and-homework-id

    return service

    !function get-homeworks
      return api-resolver.resolve 'lb_homeworks@query' .then (result) ->
              result

    !function get-homeworks-by-class-id (class-id)
      return api-resolver.resolve 'lb_homeworks@query' .then (result) ->
              homeworks = []
              for i from 0 til result.length
                _class = _.remove result[i].classes, (c) -> c.classId is class-id
                homeworks.push {
                  homework-id: result[i].homework-id
                  title: result[i].title
                  description: result[i].description
                  class: _class[0]
                }
              Promise.resolve homeworks

    !function get-homework-by-class-and-homework-id (class-id, homework-id)
        filter =
          "where":
            "homeworkId": homework-id
        return api-resolver.resolve 'lb_homeworks@query', {"filter": filter} .then (result) ->
            homeworks = filter-homework-by-class-id result, class-id
            Promise.resolve homeworks


    !function filter-homework-by-class-id (homeworks, class-id)
        homeworks = []
        for i from 0 til homeworks.length
            _class = _.remove homeworks[i].classes, (c) -> c.classId is class-id
            homeworks.push {
                homework-id: homeworks[i].homework-id
                title: homeworks[i].title
                description: homeworks[i].description
                class: _class[0]
            }
        return homeworks
