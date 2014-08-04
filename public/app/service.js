angular.module('allianceService', ['ngResource'])


  .factory('MediumResource', function($resource) {
    return $resource("/medium/resources/:id", { id: '@id' }, {
      update:  { method: 'PUT'},
      form_fields: {method: 'GET', isArray: true, url: '/medium/resources/:id/form_fields.json'},
      of_form: {method: 'GET',isArray: false,url: '/medium/resources/:id/of_form.json'},
      of_field_table: {method: 'GET',isArray: true,url: '/medium/resources/:id/of_field_table.json'},
      of_resource_desc: {method: 'GET',isArray: true,url: '/medium/resources/of_resource_desc.json'},
      save: {method: 'POST',isArray: false,url: '/medium/resources/create',params: {authenticity_token: $('meta[name="csrf-token"]').attr('content')}}
    });
  })

  .factory('LinkManage', function($resource) {
    return $resource("/link_manage/:id.json", { id: '@id' }, {
      update:  { method: 'PUT'},
      convert: {method: 'GET', isArray: false, url: '/link_manage/convert.json'}
    });
  })

  .factory('Merchant', function($resource) {
    return $resource("/merchant/:id.json", { id: '@id' }, {
      update:  { method: 'PUT'},
      products: {method: 'GET', isArray: false, url: '/merchant/products.json'}
    });
  })

  .factory('ExpandRequest', function($resource) {
    return $resource("/expand_request/:id.json", { id: '@id' }, {
      update:  { method: 'PUT'},
      query: {method: 'GET', isArray: true, url: '/expand_request'},
      save: {method: 'POST',isArray: false,url: '/expand_request/create',params: {authenticity_token: $('meta[name="csrf-token"]').attr('content')}}
    });
  })

  .factory('AdminHome', function($resource) {
    return $resource("/admin/home/:id.json", { id: '@id' }, {
      update:  { method: 'PUT'},
      sum: {method: "GET",isArray: false,url: '/admin/home/sum.json'},
      of_place: {method: "GET",isArray: true,url: '/admin/home/of_place.json'},
      of_entity: {method: "GET",isArray: true,url: '/admin/home/of_entity.json'}
    });
  })

  .factory('AdminStatistics', function($resource) {
    return $resource("/admin/statistics/:id.json", { id: '@id' }, {
      update:  { method: 'PUT'}
    });
  })

  .factory('AdminUser', function($resource) {
    return $resource("/admin/users/:id.json", { id: '@id' }, {
      update:  { method: 'PUT'},
      query: {method: "GET", isArray: false, url: '/admin/users'}
    });
  })

  .factory('ExpandUnit', function($resource) {
    return $resource('/expand/units/:id.json',
      {id: '@id'},
      {
        update: {method: 'PUT'},
        had: {method: 'GET',isArray: false,url: '/expand/units/had.json?page=:page'},
        save: {method: 'POST',isArray: false,url: '/expand/units/create',params: {authenticity_token: $('meta[name="csrf-token"]').attr('content')}},
        get: {method: 'GET',isArray: false, url: '/expand/units/show'}
      });
  })

  .factory('ExpandPlace', function($resource) {
    return $resource('/expand/places/:id.json',
      {id: '@id'},
      {
        update: {method: 'PUT'},
        of_content: {method: "GET",isArray: true,url: '/expand/places/:id/content.json'},
        of_user: {method: "GET",isArray: true,url: '/expand/places/of_user.json'},
        query: {method: 'GET', isArray: true, url: '/expand/places'}
      });
  })

  .factory('ExpandStatistics', function($resource) {
    return $resource('/statistics/:id.json',
      {id: '@id'},
      {
        update: {method: 'PUT'},
        of_medium: {method: 'GET',isArray: true,url: '/statistics/of_medium.json'},
        of_brand: {method: 'GET',isArray: true,url: '/statistics/of_brand.json'},
        of_product: {method: 'GET',isArray: true,url: '/statistics/of_product.json'},
        of_graph: {method: 'GET',isArray: true,url: '/statistics/of_graph.json'}
      });
  })

  .factory('ProductSearch', function($resource) {
    return $resource('/expand/products/:id.json',
      {id: '@id'},
      {
        update: {method: 'PUT'},
        search: {method: "GET",isArray: false,url: '/expand/products/search.json?product=:product&page=:page'}
      });
  })

  .factory('expand_products', function($resource) {
    return $resource('/expand/mains/:id.json',
      {id: '@id'},
      {
        update: {method: 'PUT'},
      });
  })

  .factory('SelfHome', function($resource) {
    return $resource('/member/home/:id.json',
      {id: '@id'},
      {
        update: {method: 'PUT'},
        sum: {method: "GET",isArray: false,url: '/member/home/sum.json'},
        of_place: {method: "GET",isArray: true,url: '/member/home/of_place.json'},
        of_entity: {method: "GET",isArray: true,url: '/member/home/of_entity.json'}
      });
  })
