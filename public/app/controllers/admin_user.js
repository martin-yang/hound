app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('admin_user', {
        url: '/admin/users',
        templateUrl: 'app/partials/admin/users/index.html',
        controller: function($scope,$state,$location,$parse,AdminUser) {
          $scope.users = AdminUser.query();
          $scope.search = function(data){
            $scope.users = AdminUser.query({page: data})
          }
      }
    })




})
