proxyTo = 'http://blockexplorer.com/testnet/q/getreceivedbyaddress/'

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
          created: new Date()
        @response.writeHead 200,
          'X-Meiny': 'Crazy'
          'Access-Control-Allow-Origin': '*'
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS'
        @response.end 200
  
  Router.map ->
    @route 'getreceivedbyaddress',
      where: 'server'
      path: '/blockexplorer/getreceivedbyaddress/:address'
      action: ->
        result = HTTP.get 'http://blockexplorer.com/testnet/q/getreceivedbyaddress/' + @params.address,
        @response.writeHead 200,
          'X-Meiny': 'Crazy'
          'Access-Control-Allow-Origin': '*'
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS'
        @response.end result.content

if Meteor.isClient
  Template.keys.keys = ->
    Keys.find().fetch()
  Template.keys.events
    'click input': (event, template) ->
      $(event.target).select();
