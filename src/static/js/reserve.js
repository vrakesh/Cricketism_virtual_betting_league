// Generated by CoffeeScript 1.7.1

/*
Author:Rakesh Vasudevan
This script handles reservation mechanisms, realtime data, some bootstrap features
 */

(function() {
  $(document).ready(function() {

    /*
    Ensuring all collpases are in a safe state
     */
    $('#bitfile_list').collapse({
      'toggle': false
    });
    $('.kerneldetailclass').collapse({
      'toggle': false
    });
    $('#kernel_list').collapse({
      'toggle': false
    });
    $('.detailclass').collapse({
      'toggle': false
    });
    $('#days').collapse({
      'toggle': false
    });
    $('#customer').collapse({
      'toggle': false
    });
    $('#reqbutton').collapse({
      'toggle': false
    });

    /*
    On clicking search for bitfile
     */
    $('#search').click(function() {
      var core_name, getblist, getklist, getlist, jsonData, platform_name;
      core_name = $('#cores').children(":selected").attr('id');
      platform_name = $('#platforms').children(":selected").attr('id');
      jsonData = [];
      if ($('#board_list').is(':hidden')) {
        getblist = $.ajax({
          url: "/bmauto/boards/" + platform_name,
          type: 'GET',
          dataType: 'json',
          contentType: 'application/json; charset=utf-8',
          error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
            return false;
          },
          success: function(response) {
            console.log("success");
            jsonData = response;
            return true;
          }
        });
        getblist.done(function() {
          var count, data, grouper, input_radio, label, main_label, _i, _len;
          console.log(jsonData);
          main_label = $('<label>').attr('for', 'board');
          main_label.html('<ins>Board</ins><span class="stars">*</span> <span class="error-message"></span>');
          $('#board_list').append(main_label);
          $('#board_list').append($('<br>'));
          if (!jQuery.isEmptyObject(jsonData)) {
            count = 1;
            for (_i = 0, _len = jsonData.length; _i < _len; _i++) {
              data = jsonData[_i];
              console.log(data);
              grouper = $('<p class="collapse in"></p>');
              $('#board_list').append(grouper);
              label = $('<label>').attr('for', data.id);
              label.html(data.board_name);
              label.addClass('notbold');
              input_radio = $('<input type="radio" name="board"></input>').attr('id', data.id);
              $(grouper).append(input_radio);
              $(grouper).append(label);
              $(grouper).append($("<br>"));
            }
          } else {
            alert("No Boards for the platform are available");
          }
          grouper = $('<p class="collapse in"></p>');
          $('#board_list').append(grouper);
          label = $('<label>').attr('for', 'any-board');
          label.html('Any');
          label.addClass('notbold');
          input_radio = $('<input type="radio" name="board" checked="checked"></input>').attr('id', 'any-board');
          $(grouper).append(input_radio);
          $(grouper).append(label);
          $(grouper).append($("<br>"));
          return $('#board_list').collapse('show');
        });
      }
      if ($('#bitfile_list').is(':hidden')) {
        getlist = $.ajax({
          url: "/bmauto/bitfiles/" + core_name + "-" + platform_name,
          type: 'GET',
          dataType: 'json',
          contentType: 'application/json; charset=utf-8',
          error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
            return false;
          },
          success: function(response) {
            console.log("success");
            jsonData = response;
            return true;
          }
        });
        getlist.done(function() {
          var count, data, grouper, input_radio, label, main_label, _i, _len;
          console.log(jsonData);
          main_label = $('<label>').attr('for', 'bitfile');
          main_label.html('<ins>Bitfile</ins><span class="stars">*</span> <span class="error-message"></span>');
          $('#bitfile_list').append(main_label);
          $('#bitfile_list').append($('<br>'));
          if (!jQuery.isEmptyObject(jsonData)) {
            count = 1;
            for (_i = 0, _len = jsonData.length; _i < _len; _i++) {
              data = jsonData[_i];
              console.log(data);
              grouper = $('<p class="collapse in"></p>');
              $('#bitfile_list').append(grouper);
              label = $('<label>').attr('for', data.id);
              label.html(data.bitfile_name);
              label.addClass('notbold');
              input_radio = $('<input type="radio" name="bitfile"></input>').attr('id', data.id);
              $(grouper).append(input_radio);
              $(grouper).append(label);
              $(grouper).append($("<br>"));
            }
          } else {
            alert("No Bitfiles were found");
          }
          grouper = $('<p class="collapse in"></p>');
          $('#bitfile_list').append(grouper);
          label = $('<label>').attr('for', 'none-bitfile');
          label.html('None');
          label.addClass('notbold');
          input_radio = $('<input type="radio" name="bitfile" checked="checked"></input>').attr('id', 'none-bitfile');
          $(grouper).append(input_radio);
          $(grouper).append(label);
          $(grouper).append($("<br>"));
          return $('#bitfile_list').collapse('show');
        });
      }
      if ($('#kernel_list').is(':hidden')) {
        getklist = $.ajax({
          url: "/bmauto/kernels/" + platform_name,
          type: 'GET',
          dataType: 'json',
          contentType: 'application/json; charset=utf-8',
          error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
            return false;
          },
          success: function(response) {
            console.log("success");
            jsonData = response;
            return true;
          }
        });
        getklist.done(function() {
          var count, data, grouper, input_radio, label, main_label, _i, _len;
          console.log(jsonData);
          main_label = $('<label>').attr('for', 'kernel');
          main_label.html('<ins>Kernel</ins><span class="stars">*</span> <span class="error-message"></span>');
          $('#kernel_list').append(main_label);
          $('#kernel_list').append($('<br>'));
          if (!jQuery.isEmptyObject(jsonData)) {
            count = 1;
            for (_i = 0, _len = jsonData.length; _i < _len; _i++) {
              data = jsonData[_i];
              console.log(data);
              grouper = $('<p class="collapse in"></p>');
              $('#kernel_list').append(grouper);
              label = $('<label>').attr('for', data.id);
              label.html(data.kernel_name);
              label.addClass('notbold');
              input_radio = $('<input type="radio" name="kernel"></input>').attr('id', data.id);
              $(grouper).append(input_radio);
              $(grouper).append(label);
              $(grouper).append($("<br>"));
            }
          } else {
            alert("No Kernels were found");
          }
          grouper = $('<p class="collapse in"></p>');
          $('#kernel_list').append(grouper);
          label = $('<label>').attr('for', 'none-kernel');
          label.html('None');
          label.addClass('notbold');
          input_radio = $('<input type="radio" name="kernel" checked="checked"></input>').attr('id', 'none-kernel');
          $(grouper).append(input_radio);
          $(grouper).append(label);
          $(grouper).append($("<br>"));
          $('#kernel_list').collapse('show');
          $('#days').collapse('show');
          $('#customer').collapse('show');
          $('#reqbutton').collapse('show');
          $('#search').text('Reset');
          $('#cores').prop('disabled', 'disabled');
          return $('#platforms').prop('disabled', 'disabled');
        });
      } else {
        if ($('#search').text() === 'Reset') {
          $('#reqbutton').collapse('hide');
          $('#customer').collapse('hide');
          $('#days').collapse('hide');
          $('#kernel_list').collapse('hide');
          $('.kerneldetailclass').collapse('hide');
          $('#bitfile_list').collapse('hide');
          $('#board_list').collapse('hide');
          $('.detailclass').collapse('hide');
          $('#cores').prop('disabled', false);
          $('#platforms').prop('disabled', false);
          $('#search').text('Search');
          $('#board_list').find('input').remove().end();
          $('#board_list').find('label').remove().end();
          $('#board_list').find('br').remove().end();
          $('#bitfile_list').find('input').remove().end();
          $('#bitfile_list').find('label').remove().end();
          $('#bitfile_list').find('br').remove().end();
          $('#kernel_list').find('input').remove().end();
          $('#kernel_list').find('label').remove().end();
          $('#kernel_list').find('br').remove().end();
        }
      }
      return true;
    });

    /*
    On clicking bitfile details fetch bitfile details
     */
    $(document).on('change', 'input[name=bitfile]', function() {
      var bitfile_id, grab, jsonData;
      console.log("change triggered");
      bitfile_id = $('input[name=bitfile]:checked').attr('id');
      jsonData = {};
      if ($('.detailclass').is(':hidden') && bitfile_id !== 'none-bitfile') {
        grab = $.ajax({
          url: "/bmauto/bitfiles/" + bitfile_id,
          type: 'GET',
          dataType: 'json',
          contentType: 'application/json; charset=utf-8',
          error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
            return false;
          },
          success: function(response) {
            console.log("success");
            jsonData = response;
            return true;
          }
        });
        grab.done(function() {
          console.log(jsonData);
          if (!jQuery.isEmptyObject(jsonData)) {
            $('#bitfile_no').text(jsonData.bitfile_no);
            $('#bitfile_core').text(jsonData.bitfile_core.core_name);
            $('#bitfile_no_cores').text(jsonData.bitfile_no_cores);
            $('#bitfile_vc').text(jsonData.bitfile_no_vc);
            $('#bitfile_icache').text(jsonData.bitfile_I_cache_size);
            $('#bitfile_dcache').text(jsonData.bitfile_D_cache_size);
            $('#bitfile_l2cache').text(jsonData.bitfile_L2_cache_size);
            $('#bitfile_FPU').text(jsonData.bitfile_FPU);
            $('#bitfile_shelves').text(jsonData.bitfile_FPU_shelves);
            $('#bitfile_freq').text(jsonData.bitfile_CPU_Freq);
          }
          $("input[name=bitfile]:not(:checked)").parent().collapse('toggle');
          return $('.detailclass').collapse('toggle');
        });
      } else {
        $('.detailclass').collapse('hide');
      }
      return true;
    });

    /*
    On clicking kernel details fetch kernel details
     */
    $(document).on('change', 'input[name=kernel]', function() {
      var grab, jsonData, kernel_id;
      console.log("change triggered");
      kernel_id = $('input[name=kernel]:checked').attr('id');
      jsonData = {};
      if ($('.kerneldetailclass').is(':hidden') && kernel_id !== 'none-kernel') {
        grab = $.ajax({
          url: "/bmauto/kernels/" + kernel_id,
          type: 'GET',
          dataType: 'json',
          contentType: 'application/json; charset=utf-8',
          error: function(jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
            return false;
          },
          success: function(response) {
            console.log("success");
            jsonData = response;
            return true;
          }
        });
        return grab.done(function() {
          console.log(jsonData);
          if (!jQuery.isEmptyObject(jsonData)) {
            $('#kernel_type').text(jsonData.kernel_type + 'bit');
            $('#kernel_pages').text(jsonData.kernel_pages + 'K');
          }
          $("input[name=kernel]:not(:checked)").parent().collapse('toggle');
          return $('.kerneldetailclass').collapse('toggle');
        });
      } else {
        return $('.kerneldetailclass').collapse('hide');
      }
    });
    $('#hide').click(function() {
      if (!$('.detailclass').is(':hidden')) {
        $('.detailclass').collapse('hide');
        $("input[name=bitfile]:not(:checked)").parent().collapse('toggle');
      }
      return true;
    });
    $('#hidek').click(function() {
      if (!$('.kerneldetailclass').is(':hidden')) {
        $('.kerneldetailclass').collapse('hide');
        $("input[name=kernel]:not(:checked)").parent().collapse('toggle');
      }
      return true;
    });
    true;
    return $('#send').click(function() {
      var bitfile_id, board_id, data_dict, kernel_id, r, xhr;
      $(this).prop('disabled', true);
      $('#form-info').html("Sending request");
      data_dict = {};
      board_id = $('input[name=board]:checked').attr('id');
      data_dict['board_id'] = board_id;
      bitfile_id = $('input[name=bitfile]:checked').attr('id');
      data_dict['bitfile_id'] = bitfile_id;
      kernel_id = $('input[name=kernel]:checked').attr('id');
      data_dict['kernel_id'] = kernel_id;
      data_dict['hours'] = $('#datebox').val();
      data_dict['board_type'] = $('#platforms').children(":selected").attr('id');
      data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val();
      r = confirm("Are you sure you want to submit the form, check the details before you click OK");
      if (r === true) {
        xhr = $.ajax({
          url: "/bmauto/reserverequest/",
          type: 'POST',
          dataType: 'text',
          data: data_dict,
          error: function(jqXHR, textStatus, errorThrown) {
            return $('#form-info').html(textStatus + errorThrown);
          },
          success: function(data, textStatus, jqXHR) {
            $('#form-info').html(textStatus + ' ' + data);
            $('#send').prop('disabled', null);
            $('#send').removeAttr('disabled');
            $('.validate-form').trigger('reset');
            $('#search').trigger('click');
            return true;
          },
          contentType: 'application/x-www-form-urlencoded'
        });
        console.log(xhr);
      }
      return true;
    });
  });

}).call(this);
