'use strict'

angular
  .module 'fuse'
  .directive 'maPageHeader', ma-page-header-directive

  !function ma-page-header-directive
    directive =
      template-url: 'app/main/directives/ma-page-header/ma-page-header.html'
      restrict: 'EA'
      scope:
        location:'@'
        name: '@'
        type: '@'

    return directive
