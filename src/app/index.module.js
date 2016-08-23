(function ()
{
    'use strict';

    /**
     * Main module of the Fuse
     */
    angular
        .module('fuse', [
            // Core
            'app.core',
            // Navigation
            'app.navigation',
            //Pages
            'app.auth',
            'app.student',
            'app.teacher'
        ]);
})();
