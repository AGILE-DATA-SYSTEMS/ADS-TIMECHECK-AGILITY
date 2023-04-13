var UIJQueryUI = function () {

    
    var handleDatePickers = function () {
        
        $("#ui_date_picker").datepicker({
        	isRTL: App.isRTL()
        });

        $("#ui_date_picker_with_button_bar").datepicker({
        	isRTL: App.isRTL(),
          showButtonPanel: true
        });

        $("#ui_date_picker_inline").datepicker({
        	isRTL: App.isRTL()
        });

        $("#ui_date_picker_change_year_month" ).datepicker({
        	isRTL: App.isRTL(),
	      changeMonth: true,
	      changeYear: true
	    });

	    $("#ui_date_picker_multiple").datepicker({
	    	isRTL: App.isRTL(),
	    	numberOfMonths: 2,
      		showButtonPanel: true
	    });

	    $( "#ui_date_picker_range_from" ).datepicker({
	    	isRTL: App.isRTL(),
	      defaultDate: "+1w",
	      changeMonth: true,
	      numberOfMonths: 2,
	      onClose: function( selectedDate ) {
	        $( "#ui_date_picker_range_to" ).datepicker( "option", "minDate", selectedDate );
	      }
	    });
	    $( "#ui_date_picker_range_to" ).datepicker({
	    	isRTL: App.isRTL(),
	      defaultDate: "+1w",
	      changeMonth: true,
	      numberOfMonths: 2,
	      onClose: function( selectedDate ) {
	        $( "#ui_date_picker_range_from" ).datepicker( "option", "maxDate", selectedDate );
	      }
	    });

	    $("#ui_date_picker_week_year" ).datepicker({
	    	isRTL: App.isRTL(),
	      showWeek: true,
	      firstDay: 1
	    });

	    $("#ui_date_picker_trigger input").datepicker({
	    	isRTL: App.isRTL()
	    });
	    $("#ui_date_picker_trigger .add-on").click(function(){
	    	$("#ui_date_picker_trigger input").datepicker("show");
	    });
    }

    return {
        //main function to initiate the module
        init: function () {
            handleDatePickers();
        }

    };

}();