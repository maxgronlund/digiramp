

/* global $ */
/* this is an example for validation and change events */
$.fn.numericCommonWorkInput = function () {
	'use strict';
	var element = $(this),
	
    /*footer = element.find('tfoot tr'),*/
		dataRows = element.find('tbody tr')
		/*
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
    */
	element.find('td').on('change', function (evt, newValue) {

		var cell = $(this),
		column  = cell.index(),
		total   = 0;
    var class_name = cell.attr('class');
    var account_id      = $('.account_id').attr('id');
    //var catalog_id      = $('.catalog_id').attr('id');
    //var common_work_id  = $('.common_work_id').attr('id');
    var id = cell.attr('id');


    var url = "/account/accounts/" + account_id + "/common_works/" + id;
    var obj = jQuery.parseJSON( '{ "common_work": {"'+class_name+'": "'+newValue+'"} }' );

    $.ajax(
      {  url: url,
        type: "PUT",
        data: obj
      }
    );

  
    /*
		element.find('tbody tr').each(function () {
			var row = $(this);
			total += parseFloat(row.children().eq(column).text());
		});
  
 
		if (column > 0 && total > 200) {
			$('.hide-alert').show();
			return false; // changes can be rejected
		} else {
			$('.hide-alert').hide();
			footer.children().eq(column).text(total);
		}
    */
  
	}).on('validate', function (evt, value) {
    /*
		var cell = $(this),
			column = cell.index();
		if (column === 0) {
			return !!value && value.trim().length > 0;
		} else {
			return !isNaN(parseFloat(value)) && isFinite(value);
		}
    */
	});
	/*initialTotal();*/
	return this;
};


ready = function(){
  $('#mainTable').editableTableWidget().numericCommonWorkInput().find('td:first').focus();
  $('#textAreaEditor').editableTableWidget({editor: $('<textarea>')});
}


$(document).ready(ready);
$(document).on('page:load', ready);