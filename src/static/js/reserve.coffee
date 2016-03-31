###
Author:Rakesh Vasudevan
This script handles reservation mechanisms, realtime data, some bootstrap features
###
$(document).ready ->
 
  ###
  Ensuring all collpases are in a safe state
  ###
  $('#bitfile_list').collapse({'toggle': false})
  $('.kerneldetailclass').collapse({'toggle': false})
  $('#kernel_list').collapse({'toggle' : false})
  $('.detailclass').collapse({'toggle': false})
  $('#days').collapse({'toggle': false})
  $('#customer').collapse({'toggle': false})
  $('#reqbutton').collapse({'toggle': false})
  

        

  ###
  On clicking search for bitfile
  ###
  $('#search').click ->
    #Read the core and platform selected by the user
    core_name = $('#cores').children(":selected").attr('id')
    platform_name = $('#platforms').children(":selected").attr('id')
    jsonData = []
    #if the list of boards is hidden (i.e before search) we return searched value as a list
    if $('#board_list').is(':hidden')
        #Ajax call to get the list, this part of the application works in REST style
        getblist = $.ajax
            url: "/bmauto/boards/"+platform_name
            type: 'GET'
            dataType: 'json'
            contentType:'application/json; charset=utf-8'
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
                false
            success:(response) ->
                console.log("success")
                jsonData = response
                true
        #This event ensures all the events in the done section actually execute after a succesful response
        getblist.done ->
            console.log(jsonData)
            #Generate the list of bitfiles and append it to the pre-defined list 
            main_label = $('<label>').attr('for','board')
            main_label.html('<ins>Board</ins><span class="stars">*</span> <span class="error-message"></span>')
            $('#board_list').append main_label
            $('#board_list').append $('<br>')
            if not jQuery.isEmptyObject(jsonData)
                count = 1
                for data in jsonData
                    console.log(data)
                    grouper = $('<p class="collapse in"></p>')
                    $('#board_list').append grouper
                    label = $('<label>').attr('for',data.id)
                    label.html(data.board_name)
                    label.addClass('notbold')
                    input_radio = $('<input type="radio" name="board"></input>').attr('id', data.id)
                    $(grouper).append input_radio
                    $(grouper).append label
                    $(grouper).append $("<br>")

            else
                alert("No Boards for the platform are available")
            grouper = $('<p class="collapse in"></p>')
            $('#board_list').append grouper
            label = $('<label>').attr('for','any-board')
            label.html('Any')
            label.addClass('notbold')
            input_radio = $('<input type="radio" name="board" checked="checked"></input>').attr('id', 'any-board')
            $(grouper).append input_radio
            $(grouper).append label
            $(grouper).append $("<br>")
            $('#board_list').collapse('show')

    #if the list of bitfiles is hidden (i.e before search) we return searched value as a list
    if $('#bitfile_list').is(':hidden')
        #Ajax call to get the list, this part of the application works in REST style
        getlist = $.ajax
            url: "/bmauto/bitfiles/"+core_name+"-"+platform_name
            type: 'GET'
            dataType: 'json'
            contentType:'application/json; charset=utf-8'
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
                false
            success:(response) ->
                console.log("success")
                jsonData = response
                true
        #This event ensures all the events in the done section actually execute after a succesful response
        getlist.done ->
            console.log(jsonData)
            main_label = $('<label>').attr('for','bitfile')
            main_label.html('<ins>Bitfile</ins><span class="stars">*</span> <span class="error-message"></span>')
            $('#bitfile_list').append main_label
            $('#bitfile_list').append $('<br>')
            #Generate the list of bitfiles and append it to the pre-defined list 
            if not jQuery.isEmptyObject(jsonData)
                count = 1
                for data in jsonData
                    console.log(data)
                    grouper = $('<p class="collapse in"></p>')
                    $('#bitfile_list').append grouper
                    label = $('<label>').attr('for',data.id)
                    label.html(data.bitfile_name)
                    label.addClass('notbold')
                    input_radio = $('<input type="radio" name="bitfile"></input>').attr('id', data.id)
                    $(grouper).append input_radio
                    $(grouper).append label
                    $(grouper).append $("<br>")


            else
                alert("No Bitfiles were found")
            grouper = $('<p class="collapse in"></p>')
            $('#bitfile_list').append grouper
            label = $('<label>').attr('for','none-bitfile')
            label.html('None')
            label.addClass('notbold')
            input_radio = $('<input type="radio" name="bitfile" checked="checked"></input>').attr('id', 'none-bitfile')
            $(grouper).append input_radio
            $(grouper).append label
            $(grouper).append $("<br>")
            $('#bitfile_list').collapse('show')

    if $('#kernel_list').is(':hidden')
        #Similar to bitfile make a list of kernels identical functionality The return response is REST style
        getklist = $.ajax
            url: "/bmauto/kernels/"+platform_name
            type: 'GET'
            dataType: 'json'
            contentType:'application/json; charset=utf-8'
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
                false
            success:(response) ->
                console.log("success")
                jsonData = response
                true
        getklist.done ->
            console.log(jsonData)
            main_label = $('<label>').attr('for','kernel')
            main_label.html('<ins>Kernel</ins><span class="stars">*</span> <span class="error-message"></span>')
            $('#kernel_list').append main_label
            $('#kernel_list').append $('<br>')
            if not jQuery.isEmptyObject(jsonData)
                count = 1
                for data in jsonData
                    console.log(data)
                    grouper = $('<p class="collapse in"></p>')
                    $('#kernel_list').append grouper
                    label = $('<label>').attr('for',data.id)
                    label.html(data.kernel_name)
                    label.addClass('notbold')
                    input_radio = $('<input type="radio" name="kernel"></input>').attr('id', data.id)
                    $(grouper).append input_radio
                    $(grouper).append label
                    $(grouper).append $("<br>")
                    #              <button type="button" class="btn details-btn btn-custom bitfile" id="details">Details</button>

            else
                alert("No Kernels were found")
            grouper = $('<p class="collapse in"></p>')
            $('#kernel_list').append grouper
            label = $('<label>').attr('for','none-kernel')
            label.html('None')
            label.addClass('notbold')
            input_radio = $('<input type="radio" name="kernel" checked="checked"></input>').attr('id', 'none-kernel')
            $(grouper).append input_radio
            $(grouper).append label
            $(grouper).append $("<br>")
            $('#kernel_list').collapse('show')
            $('#days').collapse('show')
            $('#customer').collapse('show')
            $('#reqbutton').collapse('show')
            $('#search').text('Reset')
            $('#cores').prop('disabled','disabled')
            $('#platforms').prop('disabled','disabled')
    else
        if($('#search').text() is 'Reset')
            $('#reqbutton').collapse('hide')
            $('#customer').collapse('hide')
            $('#days').collapse('hide')
            $('#kernel_list').collapse('hide')
            $('.kerneldetailclass').collapse('hide')
            $('#bitfile_list').collapse('hide')
            $('#board_list').collapse('hide')
            $('.detailclass').collapse('hide')
            $('#cores').prop('disabled',false)
            $('#platforms').prop('disabled', false)
            $('#search').text('Search')
            $('#board_list').find('input').remove().end()
            $('#board_list').find('label').remove().end()
            $('#board_list').find('br').remove().end() 
            $('#bitfile_list').find('input').remove().end()
            $('#bitfile_list').find('label').remove().end()
            $('#bitfile_list').find('br').remove().end()    
            $('#kernel_list').find('input').remove().end()
            $('#kernel_list').find('label').remove().end()
            $('#kernel_list').find('br').remove().end()
    true
                 
                
  ###
  On clicking bitfile details fetch bitfile details
  ###
  $(document).on 'change', 'input[name=bitfile]', ->
    console.log("change triggered")
    bitfile_id = $('input[name=bitfile]:checked').attr('id')
    jsonData = {}
    if $('.detailclass').is(':hidden') and bitfile_id != 'none-bitfile'
        grab = $.ajax
            url: "/bmauto/bitfiles/"+bitfile_id
            type: 'GET'
            dataType: 'json'
            contentType: 'application/json; charset=utf-8',
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
                false
            success:(response) ->
                console.log("success")
                jsonData = response
                true
        grab.done ->
            console.log(jsonData)
            if not jQuery.isEmptyObject(jsonData)
                $('#bitfile_no').text(jsonData.bitfile_no)
                $('#bitfile_core').text(jsonData.bitfile_core.core_name)
                $('#bitfile_no_cores').text(jsonData.bitfile_no_cores)
                $('#bitfile_vc').text(jsonData.bitfile_no_vc)
                $('#bitfile_icache').text(jsonData.bitfile_I_cache_size)
                $('#bitfile_dcache').text(jsonData.bitfile_D_cache_size)
                $('#bitfile_l2cache').text(jsonData.bitfile_L2_cache_size)
                $('#bitfile_FPU').text(jsonData.bitfile_FPU)
                $('#bitfile_shelves').text(jsonData.bitfile_FPU_shelves)
                $('#bitfile_freq').text(jsonData.bitfile_CPU_Freq)
            $("input[name=bitfile]:not(:checked)").parent().collapse('toggle')
            $('.detailclass').collapse('toggle')
            
    else
        $('.detailclass').collapse('hide')

    true

                
  ###
  On clicking kernel details fetch kernel details
  ###
  $(document).on 'change', 'input[name=kernel]', ->
    console.log("change triggered")
    kernel_id = $('input[name=kernel]:checked').attr('id')
    jsonData = {}
    if $('.kerneldetailclass').is(':hidden') and kernel_id != 'none-kernel'
        grab = $.ajax
            url: "/bmauto/kernels/"+kernel_id
            type: 'GET'
            dataType: 'json'
            contentType: 'application/json; charset=utf-8',
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
                false
            success:(response) ->
                console.log("success")
                jsonData = response
                true
        grab.done ->
            console.log(jsonData)
            if not jQuery.isEmptyObject(jsonData)
                $('#kernel_type').text(jsonData.kernel_type+'bit')
                $('#kernel_pages').text(jsonData.kernel_pages+'K')

            $("input[name=kernel]:not(:checked)").parent().collapse('toggle')
            $('.kerneldetailclass').collapse('toggle')
            
    else
        $('.kerneldetailclass').collapse('hide')
  #Hide events for the realtime info on bitfile and kernel        
  $('#hide').click ->
    if not $('.detailclass').is(':hidden')
      $('.detailclass').collapse('hide')
      $("input[name=bitfile]:not(:checked)").parent().collapse('toggle')
    true
  $('#hidek').click ->
    if not $('.kerneldetailclass').is(':hidden')
      $('.kerneldetailclass').collapse('hide')
      $("input[name=kernel]:not(:checked)").parent().collapse('toggle')
    true
  true
  
  #Send all collected data to the server. 
  $('#send').click ->
    $(this).prop('disabled',true)
    $('#form-info').html("Sending request")
    data_dict = {}
    board_id = $('input[name=board]:checked').attr('id')
    data_dict['board_id'] = board_id
    bitfile_id = $('input[name=bitfile]:checked').attr('id')
    data_dict['bitfile_id'] = bitfile_id
    kernel_id = $('input[name=kernel]:checked').attr('id')
    data_dict['kernel_id'] = kernel_id
    data_dict['hours'] = $('#datebox').val()
    data_dict['board_type'] =  $('#platforms').children(":selected").attr('id')

    data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
    r = confirm("Are you sure you want to submit the form, check the details before you click OK")
    if(r == true)
      xhr = $.ajax
        url:"/bmauto/reserverequest/"
        type: 'POST'
        dataType:'text'
        data:data_dict
        error:(jqXHR, textStatus,errorThrown)->
            $('#form-info').html(textStatus+errorThrown)
        success:(data, textStatus, jqXHR)->
            $('#form-info').html(textStatus+' '+data)
            $('#send').prop('disabled',null)
            $('#send').removeAttr('disabled')
            $('.validate-form').trigger('reset')
            $('#search').trigger('click')
            true
        contentType: 'application/x-www-form-urlencoded'
      console.log(xhr)
    true
