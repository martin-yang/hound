app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('admin_statistics', {
        url: '/admin/statistics',
        templateUrl: 'app/partials/admin/statistics/index.html',
        controller: function($scope,$state,$location,$parse,AdminStatistics) {
          
      }
    })




})
