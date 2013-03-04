// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .


$(function() {


 	$("#trip_outbound_date").datepicker({ 
 		dateFormat: "yy-mm-dd",
 		minDate: 0
 	});


 	$("#trip_return_date").datepicker({ 
 		dateFormat: "yy-mm-dd",
 		minDate: 0
 	});

	$( "#slider-range" ).slider({
    	range: true,
    	min: 0,
    	max: 100,
    	values: [ 0, 100 ],
      	slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
      " - $" + $( "#slider-range" ).slider( "values", 1 ) );




	var $helpbutton= $("#helpbutton");
	var $help= $("#help");
	$help.hide();
	$helpbutton.click(function() {

	    if($helpbutton.attr('value') == 'Help'){                   
		    $help.show("slide", { direction: "up" },1000);
		    $(this).attr('value', 'Hide');
		}
		else{
		    $(this).attr('value', 'Help');
		    $help.hide("slide", { direction: "up" }, 1000);
		}          
	});
});