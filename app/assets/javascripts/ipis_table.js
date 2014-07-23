/* global $ */
/* this is an example for validation and change events */
$.fn.numericInputExample = function () {
	'use strict';
	var element = $(this),
		footer = element.find('tfoot tr'),
		dataRows = element.find('tbody tr'),
		initialTotal = function () {
			var column, total;
			for (column = 1; column < footer.children().size(); column++) {
				total = 0;
				dataRows.each(function () {
					var row = $(this);
					total += parseFloat(row.children().eq(column).text());
				});
				footer.children().eq(column).text(total);
			};
		};
	element.find('td').on('change', function (evt, newValue) {
    
		var cell = $(this),
			column = cell.index(),
			total = 0;
      
		if (column === 0) {
      /* FULL NAME */
      
      
      
      var account_id = 0;
      if ($('.account_id')[0]) {
        account_id = $('.account_id').attr('id');
        console.log(account_id);
      }
      
      var ipi_id = 0;
      if ($('.ipi_id')[0]) {
        ipi_id = $('.ipi_id').attr('id');
        console.log(ipi_id);
        console.log(newValue);
        
        
        $.ajax(
                {  url: "/catalog/accounts/" + account_id +  
                        "/catalogs/" + 65 + 
                        "/common_works/" + 6388 + 
                        "/common_work_ipis/" + ipi_id ,
                   type: "PUT",
                   data: {full_name: newValue}
                }
              );
              
      }
      
      

      
      
      /*
      $.getScript("/account/accounts/" + 37 + 
                  "/common_works/" + 6388 + 
                  '?common_work_ipis=' + 23049 + 
                  '&update_full_name=' + 'johny madsen' 
                );
                
       */         
			return;
		}
    
		element.find('tbody tr').each(function () {
			var row = $(this);
			total += parseFloat(row.children().eq(column).text());
		});
    
		if (column === 1 && total > 200) {
			$('.hide-alert').show();
			return false; // changes can be rejected
		} else {
			$('.hide-alert').hide();
			footer.children().eq(column).text(total);
		}
    
	}).on('validate', function (evt, value) {
		var cell = $(this),
			column = cell.index();
		if (column === 0) {
			return !!value && value.trim().length > 0;
		} else {
			return !isNaN(parseFloat(value)) && isFinite(value);
		}
	});
	initialTotal();
	return this;
};
