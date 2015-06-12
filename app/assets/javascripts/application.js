// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require 'social_share'
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
    $('#infocol_a').css({"background-color": "#e9dfe5"});
});

// function toggleDiv(aside) {
//    $("#aside").toggle();
// }

function showonlyone(thechosenone, thetitleone) {
     $('.lists').each(function(index) {
          if ($(this).attr("id") == thechosenone) {
               $(this).show(200);
          }
          else {
               $(this).hide(200);
          }
     });
     $('.ls_title').each(function(index) {
          if ($(this).attr("id") == thetitleone) {
               $(this).css({"background-color": "#e9dfe5"});
          }
          else if ($(this).attr("id") != thetitleone) {
               $(this).css({"background-color": ""});
          }; 
     });     
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

function myFace() {
window.open("https://www.facebook.com/sharer/sharer.php?u=www.staskstact.com", "_blank", "toolbar=no, scrollbars=no, resizable=no, top=150, left=400, width=500, height=500");
}