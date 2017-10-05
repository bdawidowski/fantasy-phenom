$(document).ready(function(){
    $('#user-management-table').DataTable();
    $('#data-table-other').DataTable();
    $('#canceled-management-table').DataTable();
});

$('form').submit(function(e){
    $('input[type="submit"]').val('PROCESSING...');
    $('button').html('PROCESSING...');
})