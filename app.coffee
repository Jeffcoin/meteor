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
        @response.writeHead 200,
          'Content-Type': 'application/json'
        @response.end JSON.stringify
          foo: 'bar'
  
  Router.map ->
    @route 'getreceivedbyaddress',
      where: 'server'
      path: '/testnet/q/getreceivedbyaddress/:address'
      action: ->
        result = HTTP.get 'http://blockexplorer.com/testnet/q/getreceivedbyaddress/' + @params.address,
        @response.writeHead 200,
          'X-Meiny': 'Crazy'
        @response.end result.content
