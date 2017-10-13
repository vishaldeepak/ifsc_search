let ValidationConfig= {
  init(){
    Parsley.options.trigger = "focusout";
    Parsley.options.errorsWrapper = "<div class='error-container'></div>";
    Parsley.options.errorTemplate = "<span class='error-message'></span>"

    Parsley.options.errorsContainer = function(ParsleyField){
      var $err = ParsleyField.$element.closest(".error-con");
      return $err;
    }

    $('select').on('select2:select', function(evt) {
      $(this).parsley().validate();
  });
  }
}

export default ValidationConfig