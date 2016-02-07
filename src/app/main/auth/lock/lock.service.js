(function ()
{
    'use strict';

    angular
        .module('app.auth.lock')
        .factory('lockService', function($rootScope, $state, authService){
            var service;
            return service = {
                currentUser: null,
                stateBeforeLock: null,
                lock: function(){
                    service.currentUser = authService.currentUser
                    service.stateBeforeLock = $state.current;
                    $state.go('app.lock');
                },
                unlock: function(params){
                    if (!service.currentUser || service.currentUser.username != params.username){
                        $state.go('$login');
                        return Promise.resolve('login');
                    };
                    return authService.auth({email: authService.currentUser.email, password: params.password}).then(function(result){
                        if (result.isRegisted) {
                            $state.go(service.stateBeforeLock);
                            service.stateBeforeLock = null;
                            service.currentUser = null;
                            return Promise.resolve('unlocked');
                        } else {
                            return Promise.resolve('wrong-password');
                        }
                    });
                }
            }
        });

})();