(function($) {
  $(document).ready(function() {
    $('body').noisy({
        'intensity' : 0.712, 
        'size' : 200, 
        'opacity' : 0.178, 
        'fallback' : '', 
        'monochrome' : true
    }).css('background-color', '#ef8a43');

    $('#ggs-switch').remove();
  })
}(jQuery))
