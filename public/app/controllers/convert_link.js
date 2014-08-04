app.config(
    function($stateProvider, $urlRouterProvider) {

      $stateProvider

   .state('convert_link', {
        url: '/convert_link',
        templateUrl: 'app/partials/expand/convert_link/index.html',
        controller: function($scope,$state,$location,$parse,LinkManage) {
          $scope.generate_link=function(){
            // alert($("#link").val());
            $("#covert_link_result").empty();
            LinkManage.convert({convert_link: $("#link").val()},function(data){
              html="<div class='span10' style='padding-left:20px;'><div class='widget-box'><div class='widget-title title-bar'><span>推广链接</span></div>"
              html=html+"<div>"+data["new_path"]+"</div>"
              html=html+"</div>"
              $("#covert_link_result").append(html);
            })
          }
      }
    })




})
