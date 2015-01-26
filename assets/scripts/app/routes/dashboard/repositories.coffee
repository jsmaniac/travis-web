require 'routes/route'

TravisRoute = Travis.Route

Route = TravisRoute.extend
  queryParams:
    filter: { replace: true }
  model: ->
    apiEndpoint = @get('config').api_endpoint
    login = @controllerFor('currentUser').get('login')
    $.ajax(apiEndpoint + '/repos?member='+ login, {
      beforeSend: (xhr) ->
        xhr.setRequestHeader('accept', 'application/json; version=2')
    }).then (response) ->
      response.repos.map (elem) ->
        [owner, name] = elem.slug.split('/')
        elem.owner = owner
        elem.name = name
        Ember.Object.create(elem)

Travis.DashboardRepositoriesRoute = Route