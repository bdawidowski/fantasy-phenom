$(document).ready(function(){
    $('#user-management-table').DataTable();
    $('#data-table-other').DataTable();
    $('#canceled-management-table').DataTable();
    $('div.alert').fadeOut(3000);
    
    $('input[type="submit"]').click(function(e){
        $(this).val('PROCESSING...');
        //$('button').html('PROCESSING...');
    })
    $('button').click(function(e){
        $(this).html('PROCESSING...');
    })
    
});

//$('form').submit(function(e){
//    $('input[type="submit"]').val('PROCESSING...');
//    $('button').html('PROCESSING...');
//})

//$('input[type="submit"]').click(function(e){
//    $(this).val('PROCESSING...');
//    $('button').html('PROCESSING...');
//})
