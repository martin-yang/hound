app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('admin', {
        url: '/admin/home',
        templateUrl: 'app/partials/admin/home/index.html',
        controller: function($scope,$state,$location,$parse,AdminHome,ExpandStatistics) {
          $scope.rate_sum=AdminHome.sum();
          $scope.of_brands=ExpandStatistics.of_brand();
          $scope.of_products=ExpandStatistics.of_product();
      }
    })




})
