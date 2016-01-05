# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.js-btn-car-view').click ->
    id = $(this).data()['code']
    if id?
      window.location = "/cars/"+id
