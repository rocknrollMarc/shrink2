//TODO Eliminate propagation of speed: 'fast'
jQuery.fn.extend({
  fadeOutAndRemove: function(callback) {
    return this.fadeOut('fast', function() {
      if (callback != null) {
        callback(jQuery(this));
      }
      jQuery(this).remove();
    });
  },
  fadeOutAndBlank: function(speed) {
    return this.fadeOut(speed, function() {
      jQuery(this).html('');
    });
  },
  fadeOutAndIn: function(callback) {
    return this.fadeOut('fast', function() {
      if (callback != null) {
        callback(jQuery(this));
      }
      jQuery(this).fadeIn('fast');
    });
  },
  fadeOutAndInAndReplace: function(html, postFadeInCallback) {
    this.fadeOutAndIn(function(object) {
      object.html(html);
      if (postFadeInCallback) {
        postFadeInCallback(object);
      }
    });
  },
  hideAndBlank: function() {
    this.hide();
    return this.html('');
  },
  makeDraggableWithin: function(containment, startCallback) {
    this.draggable({
      containment: containment,
      revert: true,
      start: function(event, ui) {
        if (startCallback) {
          startCallback(this);
        }
      }
    });
  },
  positionInParent: function() {
    var childElements = this.parent().children(this.tagName);
    var childElementIds = jQuery.map(childElements, function (childElement) {
      return $(childElement).attr('id')
    });
    return $.inArray(this.attr('id'), childElementIds);
  }
});
