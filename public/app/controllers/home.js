app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('home', {
        url: '/home',
        templateUrl: 'app/partials/home/index.html',
        controller: function($scope,$state,$location,$parse,$http,SelfHome) {
          $scope.rate_sum=SelfHome.sum();
      }
    })




})
