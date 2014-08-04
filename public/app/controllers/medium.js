app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

 	.state('medium', {
        url: '/medium/resources',
        templateUrl: 'app/partials/mediums/index.html',
        controller: function($scope,$state,$location,$parse,MediumResource) {
          $scope.resources=MediumResource.query(function success(data){
            $scope.resource=data[0];
          })
      }
  	})

    .state('medium.of_form',{
      url: '/:id/of_form',
      templateUrl: 'app/partials/mediums/content.html',
      controller: function($scope,$state,$location,$stateParams,MediumResource) {
        $scope.resource=MediumResource.of_form({id: $stateParams.id});
        $scope.field_table=MediumResource.of_field_table({id: $stateParams.id},function success(data){
          var html_elements="<table class='table'>"
          html_elements=html_elements+"<tr>"
          angular.forEach(data[0],function(k){
            html_elements=html_elements+"<th>"+k+"</th>"
          })
          html_elements=html_elements+"</tr>"
          for(var i=1;i<data.length;i++){
            html_elements=html_elements+"<tr>"
            angular.forEach(data[i],function(k){
              html_elements=html_elements+"<td>"+k+"</td>"
            })
            html_elements=html_elements+"</tr>"
          }
          html_elements=html_elements+"</table>"
          $(".wideget-content-table").append(html_elements);
        });
      }
    })

  	.state('medium.of_form.new', {
        url: '/new',
        templateUrl: 'app/partials/mediums/form.html',
        controller: function($scope,$state,$location,$parse,MediumResource, $log) {
          $scope.form_fields=MediumResource.form_fields({id: $scope.$parent.resource.id}, function success (data) {
            angular.forEach(data,function(v,k){
              var html_elements="<div class='form-group'><label class='control-label'>"+
              v.name+":</label><div class='controls'>"+v.fields+"</div></div>"
              $("#elements").append(html_elements);
            });
          })
          $scope.saveData=function(data){
            var form_atts_hash=new Object();
            $(".form-horizontal input[type='text']").each(function(){
              form_atts_hash[$(this).attr('name')]=$(this).val();
            })
            $(".form-horizontal select").each(function(){
              form_atts_hash[$(this).attr('name')]=$(this).val();
            })
            $(".form-horizontal textarea").each(function(){
              form_atts_hash[$(this).attr('name')]=$(this).val();
            })
            $(".form-horizontal input[type='radio']").each(function(){
              form_atts_hash[$(this).attr('name')]=$(this).val();
            })

            // $.ajax({ 
            //   url: "/medium/resources/create",
            //   // contentType: "application/json",
            //   data: {medium_resource: form_atts_hash,form_id: $scope.$parent.resource.id,authenticity_token: $('meta[name="csrf-token"]').attr('content')},
            //   type: 'POST',
            //   async: false,
            //   dataType: "json",
            //   success: function(data){
            //     if(data["message"] == "error"){
            //       alert("错误");
            //     }else{
            //       window.location.href='/#/medium/resources/'+data["id"]+'/of_form';
            //       window.location.reload(true);
            //     }
                
            //   } 
            // });      
            
            MediumResource.save({medium_resource: form_atts_hash,form_id: $scope.$parent.resource.id},function(MediumResource){
              // $state.go('/medium/resources/'+MediumResource.id+'/of_form')
              window.location.href='/#/medium/resources/'+MediumResource.id+'/of_form';
              // alert("error");
              // $location.path('/medium/resources/'+MediumResource.id+'/of_form');
              // $state.transitionTo('medium.of_form',{id: MediumResource.id,reload: true});
              window.location.reload(true);
              // $location.reload();
              // $state.transitionTo('medium.of_form',{id: MediumResource.id,reload: true});
              // $state.forceReload();
            },function(){
              alert("错误");
            });
          }
          // $scope.update = function(data){
          //   alert($("input").val());
			      // MediumResource.save({resource:data},function(){
				    //   $state.transitionTo('medium',$state,{reload: true});
			      // },function(){
				    //   alert("error");
			      // });
		      // }
        }
  	})

    .state('medium.delete', {
        url: ':id',
        templateUrl: 'app/partials/mediums/form.html',
        controller: function($scope,$state,$location,$parse,MediumResource) {
          $scope.update = function(data){
      MediumResource.save({resource:data},function(){
        $state.transitionTo('medium',$state,{reload: true});
      },function(){
        alert("error");
      });
      }
      }
    })

})
