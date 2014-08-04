var app = angular.module('mainApp', ['ui.router', 'ui.router.state', 'ngGrid','checklist-model','ui.bootstrap',
                            'allianceService', 'ui.select2', 'angularTreeview','pascalprecht.translate']);
// app.filter('yesno', function() {
//     return function(input) {
//       if (input == true) { return '启用' };
//       return '禁用'
//     }
//   })
