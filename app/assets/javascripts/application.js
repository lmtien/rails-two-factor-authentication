//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$( document ).on('turbolinks:load', function() {
  $('.field_with_errors').parent().addClass('has-error');
})