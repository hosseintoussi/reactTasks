@Task = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    result = confirm("Are you sure you want to delete this task?");
    if result
      $.ajax
        method: 'DELETE'
        url: "/tasks/#{ @props.task.id }"
        dataType: 'JSON'
        success: () =>
          @props.handleDeleteRecord @props.task

  handleEdit: (e) ->
    e.preventDefault()
    data =
      description: React.findDOMNode(@refs.description).value
      due_date: React.findDOMNode(@refs.due_date).value
    $.ajax
      method: 'PUT'
      url: "/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      data:
        task: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.task, data

  handleStatus: (e) ->
    e.preventDefault()
    data =
      status: React.findDOMNode(@refs.status).checked
    $.ajax
      method: 'PUT'
      url: "/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      data:
        task: data
      success: (data) =>
        @props.handleEditRecord @props.task, data

  taskForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.div
          className: 'ui input'
          React.DOM.input
            type: 'text'
            defaultValue: @props.task.description
            ref: 'description'
      React.DOM.td null,
        React.DOM.div
          className: 'ui input'
          React.DOM.input
            type: 'text'
            defaultValue: @props.task.due_date
            ref: 'due_date'
      React.DOM.td null,
        React.DOM.div
      React.DOM.td null,
        React.DOM.div
          className: 'ui buttons'
          React.DOM.button
            className: 'ui positive button'
            onClick: @handleEdit
            'Update'
          React.DOM.div
            className: 'or'
          React.DOM.button
            className: 'ui button'
            onClick: @handleToggle
            'Cancel'

  taskRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.description
      React.DOM.td null, @props.task.due_date
      React.DOM.td null,
        React.DOM.input
          type: 'checkbox'
          onChange: @handleStatus
          checked: (@props.task.status ? 'checked' : '')
          ref: 'status'
      React.DOM.td null,
        React.DOM.div
          className: 'ui buttons'
          React.DOM.button
            className: 'ui positive button'
            onClick: @handleToggle
            'Edit'
          React.DOM.div
            className: 'or'
          React.DOM.button
            className: 'ui button'
            onClick: @handleDelete
            'Delete'

  render: ->
    if @state.edit
      @taskForm()
    else
      @taskRow()