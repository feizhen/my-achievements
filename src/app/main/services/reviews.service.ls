'use strict'

angular
    .module 'fuse'
    .factory 'reviewService', ReviewService

    ReviewService.$inject = ['apiResolver']

    !function ReviewService (api-resolver)
        service =
            get-reviews-by-homework-id: get-reviews-by-homework-id

        return service
    
        !function get-reviews-by-homework-id (username, homework-id)
            filter =
                "where":
                    "reviewer.username": username
                    "homeworkId": homework-id

            return api-resolver.resolve 'lb_reviews@query', { "filter": filter } .then (data)->
                    data

                


                

