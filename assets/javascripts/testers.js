(function($){
  var testers = {
    init: function(){
      this.observeProjectSelect();
      this.beforeSave();
      this.observeOtherDevice();
      this.bindSelectize();
    },

    bindSelectize: function(){
      $('.selectize').selectize({});
    },

    beforeSave: function(){
      $('#save-for-testers').on('click', function(){
        testers.validate();
        errors = $('.has-error')
        if(errors.length > 0){
          $('#flash_error').show();
          window.scrollTo(0, 0);
          return false;
        }else{
          $('#tester-form').submit();
        }
      });
    },

    observeProjectSelect: function(){
      $('#select-project').on('change', function(){
        var project_id = this.value;
        document.cookie="project_id="+project_id;
        window.location.reload();
      });
    },

    validate: function(){
      $('.has-error').removeClass('has-error'); // cleanup
      var to_valid = $('.required');

      medium_checked = $('#tester-form').find("input:checkbox:checked").length > 0
      to_valid = $(to_valid).not('div');
      for(i=0;i < to_valid.length; i++){
        if($(to_valid[i]).val() === "" || ($(to_valid[i]).attr('type') === "checkbox" && medium_checked === false)){
          $(to_valid[i]).closest('.form-group').addClass('has-error');
        }
      }
    },

    observeOtherDevice: function(){
      $('#other-device').on('change', function(){
        if($(this).is(':checked') === true){
          $('#other-device-info').removeAttr('disabled');
        }else{
          $('#other-device-info').val('');
          $('#other-device-info').attr('disabled', 'disabled');
        }
      });
    }

  }

  $(function(){
    testers.init();
  });
})(jQuery)
