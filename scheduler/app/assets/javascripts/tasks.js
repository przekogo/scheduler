$(document).on('click', '.task-delete', function(){
  deleteTask($(this).attr('target'));
}).on('click', '.task-edit', function(){
  editTask($(this).attr('target'));
}).on('click', '.task-create', function(){
  createTask();
}).on('click', '.task-run', function(){
  runTask($(this).attr('target'));
})