app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

    .state('expand_statistics', {
        url: '/expand/statistics',
        templateUrl: 'app/partials/expand/statistics/index.html',
        controller: function($scope,$state,$location,$stateParams,ExpandStatistics) {
          $scope.of_places=ExpandStatistics.query();
          $scope.of_mediums=ExpandStatistics.of_medium();
      }
    })



})
