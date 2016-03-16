(function($){
  var manage = {
    init: function(){
      this.onSelectItem();
    },

    onSelectItem: function(){
      var self = this;
      $('.splitcontentleft .table tr td').off('click').on('click', function(event) {
        var path = $(event.target).parents('tr').data('path')
        self.preview(path);
        setTimeout(function(){ self.bindEditOrder(); }, 500);
      });
    },

    bindEditOrder: function(){
      var self = this;
      $('#edit-order').on('click', function(){
        var path = this.dataset.path;
        $.ajax({
          url: path
        }).done(function( data ) {
          $('#panel-edit').empty().append(data);
          setTimeout(function(){ self.bindButtons(); }, 500);
        });
      });
    },

    bindButtons: function(){
      var self = this,
          inputs = null,
          id = null;
      $('#save-order').on('click', function(){
        var postData = $('#tester-edit-form').serializeArray();
        var formURL = $('#tester-edit-form').attr("action");
        inputs = $('#tester-edit-form').find('input, select');
        id = formURL.split('/').pop();
        $.ajax({
            url : formURL,
            type: "POST",
            data : postData,
         }).done(function( data ){
            $('.splitcontentright').empty().append($(data).html());
            $('.splitcontentright').fadeIn('fast');
            for(i=0; i < inputs.length; i++){
              var name = inputs[i].name.replace(/[[\]]/g,'').replace('testers',''),
                  new_txt = null;
              if(name !== 'utf8'){
                if(inputs[i].tagName === "INPUT"){
                  new_txt = $(inputs[i]).val();
                }else{
                  new_txt = $(inputs[i].selectedOptions).text();
                }
                class_name = name + "-" + id;
                elm = document.getElementsByClassName(class_name);
                if(name == 'status'){
                 new_txt = '(' + new_txt + ')'
                }
                $(elm).text(new_txt);
              }
            }
            setTimeout(function(){ $('#flash_order').fadeOut( "slow" ); }, 1000);
            setTimeout(function(){ self.bindEditOrder(); }, 500);
         });
      });
      $('#cancel-order').on('click', function(){
        $('.splitcontentright').fadeOut('fast');
      });
    },

    preview: function(path){
      $.ajax({
        url: path
      }).done(function( data ) {
        $('.splitcontentright').empty().append($(data).html());
        $('.splitcontentright').fadeIn('fast');
      });
    }
  }

  $(function(){
    manage.init();
  });
})(jQuery)
