let Branch = {
  init(){
    let _state_selector = $("#state_select")
    let _bank_selector = $("#bank_select")
    let _form = $("form#branch-search")
    let _search_term = $("#branch-search .branch-text")
    let csrf = $("meta[name=csrf]").attr("content")
    _form.on("submit", function(event) {
      event.preventDefault()
      if(_form.parsley().isValid())
      {
        $("#submit-ifsc").addClass("active-anim")
        $("#submit-ifsc").attr("disabled", true)
        $.ajax({
          url:  "/ifsc_search",
          type: 'POST',
          data: {
            state_id: _state_selector.val(),
            bank_id: _bank_selector.val(),
            search_term: _search_term.val()
          },
          headers: {
              "X-CSRF-TOKEN": csrf
          },
          error: function(data) {
            $("#branch-search-results").html("<div class='text-center alert alert-danger'> Something went wrong. Try Again </div>")
          },
          complete: function(data) {
            $("#submit-ifsc").removeClass("active-anim")
            $("#submit-ifsc").removeAttr("disabled")
            if ($(document).height() > ($(window).height() + 100) ) {
              $(".scroll-to-top").removeClass("d-none")
             } else{
              $(".scroll-to-top").addClass("d-none")
             }
          }
        })
      }
    })
    this.intializeSelect2(_state_selector, _bank_selector)
  },
  intializeSelect2(_state_selector, _bank_selector){
    _state_selector.select2()
    _bank_selector.select2()
  }
}

export default Branch