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
        max: 1600000,
        values: [0, 1000000],
        slide: function (event, ui) {
            $("#priceRange").val("[" + ui.values[0] + "-" + ui.values[1] + "]" + "Won");
        }
    });
    $("#priceRange").val("[" + $("#price-range").slider("values", 0) + "-" + $("#price-range").slider("values", 1) + "]" + "Won");

    //price 2
    $("#price-range-P").slider({
        range: true,
        min: 0,
        max: 1600000,
        step: 50,
        values: [50, 1000000],
        slide: function (event, ui) {
            $("#priceRangeP").val("[ " + "Won" + ui.values[0] + " - " + "Won" + ui.values[1] + " ]");
        }
    });
    $("#priceRangeP").val("[ " + "Won" + $("#price-range-P").slider("values", 0) + " - " + "Won" + $("#price-range-P").slider("values", 1) + " ]");

   
})(jQuery);