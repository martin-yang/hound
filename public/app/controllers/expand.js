app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

    .state('expand', {
        url: '/expand/products',
        templateUrl: 'app/partials/expand/units/index.html',
        controller: function($scope,$state,$location,$stateParams,$compile,ExpandUnit,ProductSearch) {
          $scope.search = function(data){
            $('#wait_modal').modal('show');
            $("#show_new_path").empty();
            $scope.search_product=ProductSearch.search({product:$("#search_name").val(),page: data},function success(data){
              $('#wait_modal').modal('hide');
            });

          }


      }
  	})



 	.state('expand.new', {
        url: '/:id/new_of_product',
        templateUrl: 'app/partials/expand/units/new.html',
        controller: function($scope,$state,$location,$stateParams,ExpandPlace,ExpandUnit,MediumResource) {
          // alert($stateParams.id);
          $scope.resources=MediumResource.of_resource_desc();
          $scope.places=ExpandPlace.of_user(function success(data){
            var html_elements="<select id='place_name' class='form-control' placeholder='必填项' required>"
            for(var i=0;i<data.length;i++){
              html_elements=html_elements+"<option value='"+data[i]["name"]+"'>"+data[i]["name"]+"</option>"
            }
            html_elements=html_elements+"</select>"
            angular.element("#place_names").append(html_elements);
          });
          // alert($stateParams.id);

          $scope.update = function(data){
			      ExpandUnit.save({unit:data,place_name:$("#place_name").val(),expand_request_id: $stateParams.id},function(ExpandUnit){
				      // $state.go('/expand/units/'+ExpandUnit.id)
				      // $location.url('/expand/units/'+ExpandUnit.id)
				      $state.transitionTo('expand.show',{id: ExpandUnit.id,reload: true});
			      },function(){
				      alert("error");
			      });
		      }
          $scope.had_place=function had_places(){
            $("#place_names").empty();
            ExpandPlace.of_user(function success(data){
              var html_elements="<select id='place_name' class='form-control' placeholder='必填项' required>"
              for(var i=0;i<data.length;i++){
                html_elements=html_elements+"<option value='"+data[i]["name"]+"'>"+data[i]["name"]+"</option>"
              }
              html_elements=html_elements+"</select>"
              angular.element("#place_names").append(html_elements);
            });
          }
          $scope.create_place=function(){
            $("#place_names").empty();
            angular.element("#place_names").append("<input class='form-control' id='place_name' type='text' value='' placeholder='必填项' required/>");
          }
        }
  	})

  	.state('expand.show', {
        url: '/:id',
        templateUrl: 'app/partials/expand/units/new_path.html',
        controller: function($scope,$state,$location,$stateParams,ExpandUnit) {
          $scope.category=ExpandUnit.get({id: $stateParams.id});
          // $scope.$parent.categories=ExpandUnit.query();
      }
  	})

})
