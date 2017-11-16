let Bank = {
  init(){
    $(document).on("select2:select", ".bank-selector", (event) => {
      let bank_id = $(event.target).select2("val")
      window.location.href = `banks/${bank_id}`
    })

    $(document).on("select2:select", ".state-bank-selector", (event) => {
      let state_id = $(event.target).select2("val")
      let csrf = $("meta[name=csrf]").attr("content")
      $.ajax({
        url:  "/get_districts_from_state",
        type: 'POST',
        data: {
          state_id: state_id,
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
    })
  }
}

export default Bank;