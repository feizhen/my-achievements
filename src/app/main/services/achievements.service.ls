'use strict'

angular
  .module 'fuse'
  .factory 'achievementsService', AchievementsService

  AchievementsService.$inject = ['apiResolver']

  !function AchievementsService (api-resolver)

    service =
      get-user-scores: get-user-scores
      get-user-score : get-user-score
      get-user-ranks : get-user-ranks
      get-user-rank  : get-user-rank
      get-rank-list  : get-rank-list

    return service

    !function get-rank (score, data)
      data.sort (a, b)-> b.final-score - a.final-score
      for i from 1 to data.length
        if data[i-1].final-score == score then return i

    !function get-user-scores (username)
      filter =
        "where":
          "reviewee.username": username
          "reviewer.role": "teacher"

      return api-resolver.resolve 'lb_reviews@query', {"filter": filter} .then (result) ->
              scores = [review.score for review in result]

    !function get-user-score (username, homework-id)
      filter =
        "where":
          "reviewee.username": username
          "homework_id": homework-id
          "reviewer.role": "teacher"

      return api-resolver.resolve 'lb_reviews@query', {"filter": filter} .then (data) ->
              data

    !function get-user-rank (username, class-id, homework-id)
      filter =
        "where":
          "class": class-id
          "homework_id": homework-id
          "reviewer.role": 'teacher'

      return api-resolver.resolve 'lb_reviews@query', {"fuilter": filter} .then (data) ->
              get-user-score username, homework-id .then (userData) ->
                get-rank user-data[0].final-score, data

    !function get-user-ranks (username, class-id)
      filter =
        "where":
          "class": class-id
          "reviewer.role": 'teacher'

      return api-resolver.resolve 'lb_reviews@query', {"filter": filter} .then (data) ->
                get-user-scores username .then (scores) ->
                  ranks = []
                  for i from 0 til scores.length
                    homework_i_data = _.filter data, (review) -> review.homework_id is i+1
                    rank = get-rank scores[i], homework_i_data
                    ranks.push rank
                  ranks

    !function get-rank-list (class-id, homework-id)
      filter =
        "where":
          "class": class-id
          "homework_id": homework-id
          "reviewer.role": 'teacher'

      return api-resolver.resolve 'lb_reviews@query', { "filter": filter } .then (data) ->
                pre-data = []
                for i from 0 to data.length - 1
                  pre-data.push data[i]
                result = _.order-by pre-data, 'score', 'desc'
                result
