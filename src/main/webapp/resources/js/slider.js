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
        min: 0,
        max: 1000,
		step: 1,
		animate : 'slow',
        values: [0, 1000],
        slide: function (event, ui) {
			  $("#priceStart").val(ui.values[0]);
			  $("#priceEnd").val(ui.values[1]);
        }
    });
    $("#priceStart").val($("#price-range").slider("values", 0));
	$("#priceEnd").val($("#price-range").slider("values", 1));
})(jQuery);