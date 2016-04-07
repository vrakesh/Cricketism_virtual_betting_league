// Generated by CoffeeScript 1.4.0
(function() {

  $(document).ready(function() {
    var dangerrows, donerows, opt, row, sel, selected, value, _i, _j, _k, _len, _len1, _len2;
    swampdragon.ready(function() {
      swampdragon.subscribe('match', 'matchinfo', null);
    });
    swampdragon.onChannelMessage(function(channels, message) {
      var match_status;
      match_status = message.data.match_status;
      console.log(" for each loop call");
      $('tr.matchrows').each(function() {
        var match_id, mno;
        console.log("inside each loop");
        match_id = $(this).attr('id');
        $(this).removeClass("success");
        $(this).removeClass('danger');
        $(this).removeClass('info');
        $(this).addClass(match_status['color' + match_id]);
        $(this).find('#' + 'time_left' + match_id).html(match_status['time_left' + match_id]);
        $(this).find('#' + 'odds' + match_id).html(match_status['odds' + match_id]);
        mno = $(this).find('.storedbet').attr('id');
        $('#' + mno).html(match_status[mno]);
        if ($(this).hasClass('info') || $(this).hasClass('danger')) {
          return $(this).find('select').prop('disabled', 'disabled');
        }
      });
    });
    dangerrows = $('.ttbody').find('.danger');
    if (dangerrows.length > 0) {
      for (_i = 0, _len = dangerrows.length; _i < _len; _i++) {
        row = dangerrows[_i];
        $(row).find('select').prop('disabled', 'disabled');
      }
    }
    donerows = $('.ttbody').find('.info');
    if (donerows.length > 0) {
      for (_j = 0, _len1 = donerows.length; _j < _len1; _j++) {
        row = donerows[_j];
        $(row).find('select').prop('disabled', 'disabled');
      }
    }
    sel = $('input').filter('.stored');
    for (_k = 0, _len2 = sel.length; _k < _len2; _k++) {
      selected = sel[_k];
      value = '#' + $(selected).val();
      opt = $('option').filter(value);
      $(opt).attr('selected', 'selected');
    }
    /*
        On Clicking the button generate AJAX request to save to db
    */

    $('.matchoption').change(function() {
      var data_dict;
      $('.matchoption').prop('disabled', true);
      data_dict = {};
      data_dict[$(this).parent().parent().attr('id')] = $(this).find(':selected').text();
      data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val();
      $.ajax({
        url: "/bet/update/" + $(this).parent().parent().attr('id') + '/',
        type: 'POST',
        dataType: 'text',
        data: data_dict,
        error: function(jqXHR, textStatus, errorThrown) {
          return alert(textStatus + errorThrown);
        },
        success: function(data, textStatus, jqXHR) {
          $('.matchoption').prop('disabled', null);
          $('.matchoption').removeAttr('disabled');
          if (data.indexOf('Error') > -1) {
            alert(data);
          }
          console.log('done here');
          return true;
        },
        contentType: 'application/x-www-form-urlencoded'
      });
      return true;
    });
    /*
        On Clicking the home win button generate AJAX request to save to score to db
    */

    $('.homewin').click(function() {
      var data_dict, name;
      name = $(this).attr('name');
      $('this').prop('disabled', true);
      $('this').next().prop('disabled', true);
      data_dict = {};
      data_dict['match'] = name;
      data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val();
      console.log(data_dict);
      $.ajax({
        url: "/bet/score/update/",
        type: 'POST',
        dataType: 'text',
        data: data_dict,
        error: function(jqXHR, textStatus, errorThrown) {
          return alert(textStatus + errorThrown);
        },
        success: function(data, textStatus, jqXHR) {
          $(this).prop('disabled', null);
          $(this).removeAttr('disabled');
          alert(data);
          console.log('done here');
          location.reload();
          return true;
        },
        contentType: 'application/x-www-form-urlencoded'
      });
      return true;
    });
    /*
        On Clicking the home win button generate AJAX request to save to score to db
    */

    $('.awaywin').click(function() {
      var data_dict, name;
      name = $(this).attr('name');
      $('this').prop('disabled', true);
      $('this').prev().prop('disabled', true);
      data_dict = {};
      data_dict['match'] = name;
      data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val();
      console.log(data_dict);
      $.ajax({
        url: "/bet/score/update/",
        type: 'POST',
        dataType: 'text',
        data: data_dict,
        error: function(jqXHR, textStatus, errorThrown) {
          return alert(textStatus + errorThrown);
        },
        success: function(data, textStatus, jqXHR) {
          $(this).prop('disabled', null);
          $(this).removeAttr('disabled');
          alert(data);
          console.log('done here');
          location.reload();
          return true;
        },
        contentType: 'application/x-www-form-urlencoded'
      });
      return true;
    });
    return true;
  });

}).call(this);
