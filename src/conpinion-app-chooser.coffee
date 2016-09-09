Polymer

  is: 'conpinion-app-chooser'

  properties:
    domain: {type: String, value: 'service.local'}
    method: {type: String, value: 'http'}
    apps: {
      type: Array, value: [
      ]
    },
    auto: {type: Boolean, value: false}
    activeApp: {type: Object, readOnly: true, notify: true}
    activeAppId: {type: String, notify: true, observer: '_selectApp'}
    _selectedIndex: {type: Number, observer: '_updateSelectedApp'}
    _uiSelection: {type: Boolean, value: false}

  _updateSelectedApp: ->
    @_setActiveApp @apps[@_selectedIndex]
    @_uiSelection = true
    @activeAppId = @activeApp?.id
    @_uiSelection = false

  _selectApp: (newAppId, oldAppId) ->
    if @_uiSelection
      @_openApp() if @auto && oldAppId
    else
      @_selectedIndex = (i for app, i in @apps when app.id == @activeAppId)[0]

  _openApp: ->
    url = "#{@method}://#{@activeApp.host}.#{@domain}"
    window.open url, '_self'
