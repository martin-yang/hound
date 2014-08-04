app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

    .state('expand_graph', {
        url: '/expand/statistics/graph',
        templateUrl: 'app/partials/expand/statistics/graph.html',
        controller: function($scope,$state,$location,$stateParams,$compile,ExpandStatistics) {
          $('#wait_modal').modal('show');
          $scope.of_graphes=ExpandStatistics.of_graph(function success(data){
            Morris.Line({
              element: 'expand_graph',
              data: data,
              xkey: 'day',
              ykeys: ['rates'],
              labels: ['点击量'],
              lineColors:['#0176CC']
            });
            $('#wait_modal').modal('hide');
          })

      }
    })




})
