$(document).ready(function(){
    if(document.querySelectorAll("#stripe-public-key").length > 0){
        initStrip()
        console.log('t')
    }
    $('#user-management-table').DataTable();
    $('#data-table-other').DataTable();
    $('#canceled-management-table').DataTable();
    //$('div.alert').fadeOut(3000);
    
    $('input[type="submit"]').click(function(e){
        $(this).val('PROCESSING...');
        //$(this).html('PROCESSING...');
    });
    $('button[type="submit"]').click(function(e){
        $(this).html('PROCESSING...');
    });
    var randomNum = Math.floor(Math.random() * 20);
    if ($(window).width() > 500 && randomNum < 7) {
       $('#modal-btn').click();
    }

    
});

