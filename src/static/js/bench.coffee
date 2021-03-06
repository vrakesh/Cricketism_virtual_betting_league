###
Author:Rakesh Vasudevan
This script handles benchmark mechanisms, realtime data, some bootstrap features
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
    rte_name = $('#rtes').children(":selected").attr('id')
    jsonData = []


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
            $('#bitfile_list').collapse('show')

    if $('#toolchain_list').is(':hidden')
        #Similar to bitfile make a list of toolchains identical functionality The return response is REST style
        gettlist = $.ajax
            url: "/bmauto/toolchains/"+platform_name+"-"+rte_name
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
        gettlist.done ->
            console.log(jsonData)
            main_label = $('<label>').attr('for','toolchain')
            main_label.html('<ins>Toolchain</ins><span class="stars">*</span> <span class="error-message"></span>')
            $('#toolchain_list').append main_label
            $('#toolchain_list').append $('<br>')
            if not jQuery.isEmptyObject(jsonData)
                count = 1
                for data in jsonData
                    console.log(data)
                    grouper = $('<p class="collapse in"></p>')
                    $('#toolchain_list').append grouper
                    label = $('<label>').attr('for',data.id)
                    label.html(data.toolchain_id)
                    label.addClass('notbold')
                    input_radio = $('<input type="checkbox" name="toolchain"></input>').attr('id', data.id)
                    $(grouper).append input_radio
                    $(grouper).append label
                    $(grouper).append $("<br>")
                    #              <button type="button" class="btn details-btn btn-custom bitfile" id="details">Details</button>

            else
                alert("No Toolchains were found")
            ###grouper = $('<p class="collapse in"></p>')
            $('#toolchain_list').append grouper
            label = $('<label>').attr('for','none-kernel')
            label.html('None')
            label.addClass('notbold')
            input_radio = $('<input type="radio" name="kernel" checked="checked"></input>').attr('id', 'none-kernel')
            $(grouper).append input_radio
            $(grouper).append label
            $(grouper).append $("<br>")
            ###
            $('#toolchain_list').collapse('show')
            $('#bench_list').collapse('show')
            $('#submit_button').collapse('show')
            $('#search').text('Reset')
            $('#cores').prop('disabled','disabled')
            $('#platforms').prop('disabled','disabled')
            $('#rtes').prop('disabled','disabled')
    else
        if($('#search').text() is 'Reset')
            $('#submit_button').collapse('hide')
            $('#toolchain_list').collapse('hide')
            $('#bench_list').collapse('hide')
            $('#bitfile_list').collapse('hide')
            $('.detailclass').collapse('hide')
            $('#cores').prop('disabled',false)
            $('#platforms').prop('disabled', false)
            $('#rtes').prop('disabled', false)         
            $('#search').text('Search')
            $('#bitfile_list').find('input').remove().end()
            $('#bitfile_list').find('label').remove().end()
            $('#bitfile_list').find('br').remove().end()    
            $('#toolchain_list').find('input').remove().end()
            $('#toolchain_list').find('label').remove().end()
            $('#toolchain_list').find('br').remove().end()
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

                

  #Hide events for the realtime info on bitfile and kernel        
  $('#hide').click ->
    if not $('.detailclass').is(':hidden')
      $('.detailclass').collapse('hide')
      $("input[name=bitfile]:not(:checked)").parent().collapse('toggle')
    true
  true
  
  #Send all collected data to the server. 
  $('#send').click ->
    $(this).prop('disabled',true)
    $('#form-info').html("Sending request")
    data_dict = {}
    bitfile_id = $('input[name=bitfile]:checked').attr('id')
    data_dict['bitfile_id'] = bitfile_id
    toolchains = $('input[name=toolchain]:checked')
    toolchain_str=''
    for toolchain in toolchains
        toolchain_str += $(toolchain).attr('id')+';'
    data_dict['toolchain_ids'] = toolchain_str
    benchmarks = $('.benchmarks:checked')
    benchmark_str=''
    for benchmark in benchmarks
        benchmark_str += $(benchmark).attr('id')+';'
    data_dict['benchmark_ids'] = benchmark_str    
    data_dict['board_type'] =  $('#platforms').children(":selected").attr('id')
    data_dict['rte'] = $('#rtes').children(":selected").attr("id")
    data_dict['core'] = $('#cores').children(":selected").attr("id")

    data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
    console.log(data_dict)
    r = confirm("Are you sure you want to submit the form, check the details before you click OK")
    if(r == true)
      xhr = $.ajax
        url:"/bmauto/benchrequest/"
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
