let Branch = {
  init(){
    let state_selector = $("#state_select")
    let bank_selector = $("#bank_select")
    let search_term = $("#branch-search .branch-text")
    let submit = $("#branch-search .submit")
    let csrf = document.querySelector("meta[name=csrf]").content;
    submit.on("click", function(event) {

      $.ajax({
        url:  "/ifsc_search",
        type: 'POST',
        data: {
          state_id: state_selector.val(),
          bank_id: bank_selector.val(),
          search_term: search_term.val()
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