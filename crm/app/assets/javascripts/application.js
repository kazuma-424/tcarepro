// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//
//= require jquery
//= require jquery_ujs
//= require_self
//
$(function() {
  $('.header-right').hover(function() {
    $("header-right:not(:animated)", this).slideDown();
  }, function() {
    $(".child").slideUp();
  });
});

$(function() {
  //ログインをクリックした際にフェードイン
  $('#login-show').click(function() {
    $('#login-show').fadeIn();
  });

  //新規登録をクリックした際にフェードイン
  $('.signup-show').click(function() {
    $('#signup-modal').fadeIn();
  });

  //新規登録とログインを閉じる時のフェードアウト
  $('.close-modal').click(function() {
    $('#login-modal').fadeOut();
    $('#signup-modal').fadeOut();
  });
});


//takigawa
$(document).on('turbolinks:load', function(event) {
//$(document).on('ready', function(event) {
        //company/:id
    $(document).on("click", ".edit-link-show", function () {
      data = $(this).data()
      $("#" + data.v + "-show").addClass("none")
      $("#" + data.v + "-c-input-field").removeClass("none")
    });
    $(".c-input-field").keypress( function ( e ) {
    	if ( e.which == 13 ) {
        x = $('#company-show-update').submit();
        console.log(x)
    		// return false;
    	}
    } );
    $(document).on("click", ".comment-edit", function () {
      data = $(this).data()
      $("#" + data.id + "-comment-body").toggle();
      $("#" + data.id + "-comment-edit-field").toggle();
    })
        $(document).on("click", ".comment-edit-detail", function () {
      data = $(this).data()
      $("#" + data.id + "-comment-edit-detail-field").toggle();
    })
});