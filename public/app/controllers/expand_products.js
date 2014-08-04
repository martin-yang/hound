app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

    .state('expand_products', {
        url: '/expand/mains/page/:page',
        templateUrl: 'app/partials/expand/mains/index.html',
        controller: function($scope,$state,$location,$stateParams,ExpandUnit) {
          $scope.result=ExpandUnit.had({page:$stateParams.page});
          $scope.delete = function(unit_id) {
            ExpandUnit.delete({id: unit_id})
            $state.transitionTo('expand',$state,{reload: true});
          }
      }
    })



})
