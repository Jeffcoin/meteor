@Keys = new Meteor.Collection 'keys'

if Meteor.isServer
  Router.map ->
    @route 'collectKeys',
      where: 'server'
      path: '/keys/:key/name/:name'
      action: ->
        Keys.insert
          key: @params.key
          name: @params.name
        @response.writeHead 200,
          'Content-Type': 'application/json'
        @response.end JSON.stringify
          foo: 'bar'
