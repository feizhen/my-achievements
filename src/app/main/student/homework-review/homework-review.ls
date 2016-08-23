'use strict'

angular
    .module 'app.student.homework-review', []
    .config  Student-homework-review-config

    Student-homework-review-config.$inject = ['$stateProvider']

    !function Student-homework-review-config ($state-provider)
        $state-provider
            .state 'app.student.homework-review', {
                url: '/homework-review/:id'
                resolve:
                    reviews: (auth-service, review-service, $state-params)->
                        user = auth-service.get-user!
                        homework-id = +$state-params.id
                        review-service.get-reviews-by-homework-id user.username, homework-id

                views:
                    'content@app':
                        template-url: 'app/main/student/homework-review/homework-review.html'
                        controller-as: 'vm'
                        controller: (auth-service, $state-params, reviews) !->
                            console.log reviews
                            vm = @
                            auth = auth-service
                            vm.user = auth.get-user!
            }
