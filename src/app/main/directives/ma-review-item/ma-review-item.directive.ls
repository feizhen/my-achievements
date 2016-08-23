'use strict'

angular
    .module 'fuse'
    .directive 'maReviewItem', ma-review-item-directive

    !function ma-review-item-directive
        directive = {
            template-url: 'app/main/directives/ma-review-item/ma-review-item.html'
            restrict: 'EA'
            scope:
                item: '='
            controller-as: 'vm'
            controller: ($scope) !->

        }
        return directive
