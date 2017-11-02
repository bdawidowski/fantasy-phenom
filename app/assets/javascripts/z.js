$(document).ready(function(){
    $('#user-management-table').DataTable();
    $('#data-table-other').DataTable();
    $('#canceled-management-table').DataTable();
    //$('div.alert').fadeOut(3000);
    
    $('input[type="submit"]').click(function(e){
        $(this).val('PROCESSING...');
        //$('button').html('PROCESSING...');
    })
    $('button[type="submit"]').click(function(e){
        $(this).html('PROCESSING...');
    })
    
});

