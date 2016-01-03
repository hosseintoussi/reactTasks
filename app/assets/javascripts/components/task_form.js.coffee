@TaskForm = React.createClass
  getInitialState: ->
    description: ''
    due_date: ''
    status: ''

  valid: ->
    @state.description && @state.due_date

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/tasks', { task: @state}, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'ui form'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'field'
        React.DOM.input
          type: 'text'
          placeholder: 'Description'
          name: 'description'
          value: @state.description
          onChange: @handleChange
      React.DOM.div
        className: 'field'
        React.DOM.input
          type: 'text'
          className: 'field'
          placeholder: 'Due Date'
          name: 'due_date'
          value: @state.due_date
          onChange: @handleChange
      React.DOM.div
        className: 'field'
        React.DOM.button
          type: 'submit'
          className: 'ui positive button'
          disabled: !@valid()
          'Create'