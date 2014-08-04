app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('merchant_products', {
        url: '/merchant_products',
        templateUrl: 'app/partials/merchant_products/index.html',
        controller: function($scope,$state,$location,$parse,$http,Merchant) {
          $scope.products=Merchant.products();
          $scope.search = function(data){
            $scope.products=Merchant.products({page: data})
          }
      }
    })

   .state('merchant_products.expand_request', {
        url: '/merchant_products/:id/:name/expand_request',
        templateUrl: 'app/partials/merchant_products/new.html',
        controller: function($scope,$state,$location,$stateParams,$http,Merchant,ExpandRequest) {
          $scope.expand_request = ExpandRequest.new
          $scope.product_name = $stateParams.name
          $scope.product_id = $stateParams.id
          $scope.save = function(data){
          	ExpandRequest.save({expand_request: data,product_id: $scope.product_id},function success(data){
          		$scope.$parent.products = Merchant.products();
          		$state.transitionTo('merchant_products',{reload: true});
          	});
          }
      }
    })




})
