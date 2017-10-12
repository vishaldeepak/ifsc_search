let Branch = {
  init(){
    let _state_selector = $("#state_select")
    let _bank_selector = $("#bank_select")
    let _form = $("form#branch-search")
    let _search_term = $("#branch-search .branch-text")
    let csrf = document.querySelector("meta[name=csrf]").content;
    _form.on("submit", function(event) {
      event.preventDefault()
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
          console.log("Error in response")
        }
      })
    })
  }
}

export default Branch