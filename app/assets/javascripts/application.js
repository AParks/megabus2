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
//= require jquery.tablesorter
//= require jquery_ujs
//= require jquery-ui
//= require_tree .


$(function() {




$('a').tooltip()

//table sorting
               //     $("table[class=not-sortable]").removeAttr("tablesorter");

    $('table[class*=sortable]').tablesorter({
            sortReset      : true,
            sortRestart    : true,
             headers: { 
                5: { 
                    // disable it by setting the property sorter to false 
                    sorter: false 
                } 
            } 
        }); 





//disable the submit button until at least an outbound date has been selected
    $("input[type=submit]").attr("disabled", "disabled");
    $("input").change(function(){
            //Validate your form here, example:
            var validated = true;
            if($("#trip_outbound_date").val().length === 0) 
                validated = false;
 
            //If form is validated enable form
            if(validated) {
                console.log("validated")
                $("input[type=submit]").removeAttr("disabled");
            }                             
    })

//datepickers
 	$("#trip_outbound_date").datepicker({ 
 		dateFormat: "yy-mm-dd",
        onSelect: function(dateText, inst){ 
            date_min = new Date(dateText +" EDT");
            $( "#trip_return_date").datepicker( "option", "minDate", date_min);
            var minDate = $(  "#trip_return_date" ).datepicker( "option", "minDate" );
            $("input").change();
        },
 		minDate: 0
 	});


 	$("#trip_return_date").datepicker({ 
 		dateFormat: "yy-mm-dd",
 		minDate: 0,
 	});


    //price filtering

    var originalPriceTotals = $(".route");
    var parent = originalPriceTotals[0].parentNode;
    originalPriceTotals = originalPriceTotals.toArray();

	$( "#slider-range" ).slider({
    	range: true,
    	min: 0,
    	max: 100,
    	values: [ 0, 100 ],
      	slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
        var priceTotals = originalPriceTotals;
        console.log("priceTotals" + priceTotals);

        for (var i = 0; i< priceTotals.length-1;i++){
        	var price = priceTotals[i].getAttribute("value");
        	if ( price < ui.values[ 0 ] || price > ui.values[ 1 ])
        		priceTotals[i].remove();
        	else if(originalPriceTotals.indexOf(priceTotals[i]) == -1){
        		console.log("-1")
        		parent.insertBefore(originalPriceTotals[0], priceTotals[i]);
        	}
        }
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
      " - $" + $( "#slider-range" ).slider( "values", 1 ) );



});

