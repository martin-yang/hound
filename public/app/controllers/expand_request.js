app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('expand_request', {
        url: '/expand_request',
        templateUrl: 'app/partials/expand_request/index.html',
        controller: function($scope,$state,$location,$parse,$http,ExpandRequest) {
          $scope.had_requests=ExpandRequest.query();
      }
    })



})
