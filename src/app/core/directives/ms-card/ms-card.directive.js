(function ()
{
    'use strict';

    angular.module('fuse')
        .directive('msCard', msCard);

    /** @ngInject */
    function msCard()
    {
        return {
            restrict: 'AE',
            scope   : {
                template: '=',
                card    : '=ngModel'
            },
            template: "<div ng-include='templateDir'></div>",
            compile : function (tElement)
            {
                // Add class
                tElement.addClass('ms-card');

                return function postLink($scope, $element, $attrs)
                {
                    var baseDir = 'app/core/directives/ms-card/templates/';
                    $scope.templateDir = baseDir + $scope.template + '/' + $scope.template + '.html';
                }
            }
        };
    }
})();