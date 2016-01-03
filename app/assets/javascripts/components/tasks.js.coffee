@Tasks = React.createClass
  getInitialState: ->
    tasks: @props.data
  getDefaultProps: ->
    tasks: []

  addTask: (task) ->
    tasks = React.addons.update(@state.tasks, { $push: [task] })
    @setState tasks: tasks

  deleteTask: (task) ->
    index = @state.tasks.indexOf task
    tasks = React.addons.update(@state.tasks, { $splice: [[index, 1]] })
    @replaceState tasks: tasks

  updateTask: (task, data) ->
    index = @state.tasks.indexOf task
    tasks = React.addons.update(@state.tasks, { $splice: [[index, 1, data]] })
    @replaceState tasks: tasks

  render: ->
    React.DOM.div
      className: 'ui grid'
      React.DOM.div
        className: 'five wide column'
        React.DOM.h2
          className: 'title'
          'Create a new Task'
        React.createElement TaskForm, handleNewRecord: @addTask
      React.DOM.div
        className: 'eleven wide column'
        React.DOM.h2
          className: 'title'
          'Your Tasks'
        React.DOM.table
          className: 'ui stripped table'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Description'
              React.DOM.th null, 'Due Date'
              React.DOM.th null, 'Status'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for task in @state.tasks
              React.createElement Task, key: task.id, task: task, handleDeleteRecord: @deleteTask, handleEditRecord: @updateTask