function triggerTooltips() {
  $("[data-toggle='tooltip']").tooltip();
}
function triggerPopovers() {
  $("[data-toggle='popover']").popover({
    trigger: 'click'
  })
}

function deleteTask(id) {
  // ajax call to delete task where id==id
  $.ajax({
    url: 'tasks/'+id,
    method: 'delete',
    data: {'id' : id}
  });
}
function editTask(id) {
  // show edit modal for task where id==id
  $.ajax({
    url: 'generate_modal_form',
    method: 'get',
    data: {'id' : id}
  });
}
function createTask() {
  // show create modal for task
  $.ajax({
    url: 'generate_modal_form',
    method: 'get'
  });
}
function runTask(id) {
  // manually run the task
  $.ajax({
    url: 'run_task',
    method: 'post',
    data: {'id': id}
  });
}