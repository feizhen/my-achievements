(function ()
{
    'use strict';

    angular
        .module('fuse')
        .run(runBlock);

    /** @ngInject */
    function runBlock($rootScope, $timeout, $state, authService)
    {
        // Activate loading indicator
        var auth = authService;
        auth.getUserFromCookie().then(function(user){

            if ( !user ) {

                $state.go('app.auth.login');

            }
        });

        var stateChangeStartEvent = $rootScope.$on('$stateChangeStart', function (event, toState)
        {
            $rootScope.loadingProgress = true;

            if ( auth.isLoggedIn() ) {

                if ( !auth.isAuthorizaed(toState) ) {

                    $state.go('app.error-404');

                    event.preventDefault();

                }

            } else if ( !auth.isLoggedIn() && toState.name != 'app.auth.login' ) {

                $state.go('app.auth.login');

                event.preventDefault();

            }

        });

        // De-activate loading indicator
        var stateChangeSuccessEvent = $rootScope.$on('$stateChangeSuccess', function ()
        {
            $timeout(function ()
            {
                $rootScope.loadingProgress = false;
            });
        });

        // Store state in the root scope for easy access
        $rootScope.state = $state;

        // Cleanup
        $rootScope.$on('$destroy', function ()
        {
            stateChangeStartEvent();
            stateChangeSuccessEvent();
        });
    }
})();
