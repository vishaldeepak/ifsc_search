let SearchViaCode = {
  init(){
    let _form = $("#search-via-code form")
    let _code = $("#search-via-code .ifsc-input")
    let _submit_button = $("#submit-code-search")
    let csrf = $("meta[name=csrf]").attr("content")
    _form.on("submit", function(event) {
      event.preventDefault()
      if(_form.parsley().isValid())
      {
        _submit_button.addClass("active-anim")
        _submit_button.attr("disabled", true)
        $.ajax({
          url:  "/code_search",
          type: 'POST',
          data: {
            code: _code.val(),
          },
          headers: {
              "X-CSRF-TOKEN": csrf
          },
          error: function(data) {
            $("#branch-search-results").html("<div class='text-center alert alert-danger'> Something went wrong. Try Again </div>")
          },
          complete: function(data) {
            _submit_button.removeClass("active-anim")
            _submit_button.removeAttr("disabled")
          }
        })
      }
    })
  }
}

export default SearchViaCode