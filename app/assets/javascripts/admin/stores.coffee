# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1.25
      setSelect: [0,0,600,480]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#admin_store_crop_x').val(coords.x)
    $('#admin_store_crop_y').val(coords.y)
    $('#admin_store_crop_w').val(coords.w)
    $('#admin_store_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
        width: Math.round(300/coords.w * $('#cropbox').width()) + 'px'
        height: Math.round(240/coords.h * $('#cropbox').height()) + 'px'
        marginLeft: '-' + Math.round(300/coords.w * coords.x) + 'px'
        marginTop: '-' + Math.round(240/coords.h * coords.y) + 'px'

