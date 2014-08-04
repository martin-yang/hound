app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

    .state('expand_place', {
        url: '/expand/places',
        templateUrl: 'app/partials/expand/places/index.html',
        controller: function($scope,$state,$location,$stateParams,MediumResource) {
          $scope.resources=MediumResource.query();
      }
    })

    .state('expand_place.content', {
        url: '/:id/content',
        templateUrl: 'app/partials/expand/places/table.html',
        controller: function($scope,$state,$location,$stateParams,ExpandPlace) {
          $scope.categories=ExpandPlace.of_content({id: $stateParams.id});
          // $scope.delete=function(data){
          //   alert(data);
          //   // ExpandPlace.delete({id: data})
          //   $state.transitionTo('expand_place.content',$state,{reload: true,id: $stateParams.id});
          // }
      }
    })


})
