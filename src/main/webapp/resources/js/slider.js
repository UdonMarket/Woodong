/*  ---------------------------------------------------
    Theme Name: Azenta
    Description:
    Author:
    Author URI:
    Version: 1.0
    Created:
---------------------------------------------------------  */
'use strict';


(function ($) {
    /*-------------------
		Range Slider
    --------------------- */
    //price 1
    $("#price-range").slider({
        range: true,
        min: 1,
        max: 999,
		step: 1,
		animate : 'slow',
        values: [1, 999],
        slide: function (event, ui) {
			  $("#priceStart").val(ui.values[0]+"000");
			  $("#priceEnd").val(ui.values[1]+"0000");
        }
    });
     $("#priceStart").val($("#price-range").slider("values", 0)+"000"); 
	 $("#priceEnd").val($("#price-range").slider("values", 1)+"0000"); 
})(jQuery);