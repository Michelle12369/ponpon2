(function() {
  var AvatarCropper,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jQuery(function() {
    return new AvatarCropper();
  });

  AvatarCropper = (function() {
    function AvatarCropper() {
      this.updatePreview = bind(this.updatePreview, this);
      this.update = bind(this.update, this);
      $('#cropbox').Jcrop({
        aspectRatio: 1.25,
        setSelect: [0, 0, 600, 480],
        onSelect: this.update,
        onChange: this.update
      });
    }

    AvatarCropper.prototype.update = function(coords) {
      $('#admin_store_crop_x').val(coords.x);
      $('#admin_store_crop_y').val(coords.y);
      $('#admin_store_crop_w').val(coords.w);
      $('#admin_store_crop_h').val(coords.h);
      return this.updatePreview(coords);
    };

    AvatarCropper.prototype.updatePreview = function(coords) {
      return $('#preview').css({
        width: Math.round(300 / coords.w * $('#cropbox').width()) + 'px',
        height: Math.round(240 / coords.h * $('#cropbox').height()) + 'px',
        marginLeft: '-' + Math.round(300 / coords.w * coords.x) + 'px',
        marginTop: '-' + Math.round(240 / coords.h * coords.y) + 'px'
      });
    };

    return AvatarCropper;

  })();

}).call(this);
