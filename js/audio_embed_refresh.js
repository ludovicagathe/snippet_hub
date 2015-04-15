(function(jQuery) {
  jQuery(document).ready(function() {
    var n = jQuery('embed').length;
    if (n > 0) {
      var holder, tmp_play, i = 0;
      for (i = 0; i < n; i++) {
        if (jQuery('embed').eq(i).attr('src').indexOf('audio-player.swf') > -1 && jQuery('embed').eq(i).attr('src').indexOf('http://www.google.com/reader/') > -1) {
          tmp_play = jQuery('embed').eq(i);
          tmp_play.wrap('<span class="lexp-audio-fix-' + n + '"></span>')
          tmp_play.remove();
          tmp_play.attr('src', 'http://www.lexpress.mu/sites/all/libraries/player/google_player/google-audio-step.swf');
          jQuery('.lexp-audio-fix-' + n).append(tmp_play);
        }
      }
    }
  })
})(jQuery)