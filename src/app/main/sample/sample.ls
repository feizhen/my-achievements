'use strict'
angular.module 'app.sample', []
  
  .config ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)!->
    
    $translate-partial-loader-provider.add-part 'app/main/sample'

    ms-navigation-service-provider.save-item 'fuse', {
      title : 'SAMPLE',
      group : true,
      weight: 1
    }

    ms-navigation-service-provider.save-item 'fuse.sample', {
      title    : 'Sample',
      icon     : 'icon-tile-four',
      state    : 'app.sample',
      /*stateParams: {
          'param1': 'page'
       },*/
      translate: 'SAMPLE.SAMPLE_NAV',
      weight   : 1
    }


    $state-provider.state 'app.sample', {
      url: '/sample'
      resolve: result: (api-resolver)-> api-resolver.resolve('sample@get')
      views:
        'content@app':
          template-url: 'app/main/sample/sample.html'
          controller: (result, $scope)!->
            console.log "result: ", result
            $scope.hello-text = result.data.hello-text
    }
