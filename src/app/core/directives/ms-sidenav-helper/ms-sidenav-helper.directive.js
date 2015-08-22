(function ()
{
    'use strict';

    angular.module('fuse')
        .directive('msSidenavHelper', msSidenavHelperDirective);

    /** @ngInject */
    function msSidenavHelperDirective()
    {
        return {
            restrict: 'A',
            require : '^mdSidenav',
            link    : function ($scope, $element, $attrs, MdSidenavCtrl)
            {
                // Watch md-sidenav open & locked open statuses
                // and add class to the ".page-layout" if only
                // the sidenav open and NOT locked open
                $scope.$watch(function ()
                {
                    return MdSidenavCtrl.isOpen() && !MdSidenavCtrl.isLockedOpen();
                }, function (current, old)
                {
                    if ( angular.isUndefined(current) )
                    {
                        return;
                    }

                    $scope.$evalAsync(function(){

                        $element.parents('.page-layout').toggleClass('sidenav-open', current);
                    });
                });
            }
        };
    }

})();