let Common = {
  init(){
      $.fn.select2.defaults.set( "theme", "bootstrap" );

      $(document).tooltip({
        selector: '.clipboard.copy-icon',
        title: "Copied",
        placement: "bottom",
        trigger: "click"
      });

      $(document).on('shown.bs.tooltip', '.clipboard.copy-icon', function () {
        let _element = $(this)
        setTimeout(function() {
          _element.tooltip('hide')
        }, 2000)
      })
  }
}

export default Common;