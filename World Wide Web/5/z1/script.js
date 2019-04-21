$( function() {
    $( "#asd" ).slider({
      value:3,
      min: 1,
      max: 5,
      step: 1,
      slide: function( event, ui ) {
        $( "#amount" ).val((ui.value) + " sek");
      }
    }).on('mousedown',pauseSlider).on('mouseup',startSlider);
    $( "#amount" ).val( $( "#asd" ).slider( "value" ) + " sek");
    
 $(".slides > div:gt(0)").hide();
 
 var interval;

    function startSlider() {
        interval = setInterval(function() {
            $('.slides > div:first')
            .fadeOut(1000)
            .next()
            .fadeIn(1000)
            .end()
            .appendTo('.slides');
        }, $("#asd").slider("option", "value")*1000);
    }
 
  function pauseSlider() {
        clearInterval(interval);
    }

    $('#slider').find('.slides')
        .on('mouseenter', pauseSlider)
        .on('mouseleave', startSlider);

    startSlider();

});
