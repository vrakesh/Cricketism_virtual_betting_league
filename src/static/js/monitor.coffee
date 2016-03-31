###
Author:Rakesh Vasudevan
This javascript script gets real-time information via websockets
The swampdragon model is used to get information from subscribed channels
###
$(document).ready ->
    #When swampdragon is ready subscribe to the board info channel
    swampdragon.ready ->
        swampdragon.subscribe 'board', 'boardinfo', null
        return
        
        
    #On receiving a message provide a update
    swampdragon.onChannelMessage (channels, message) ->
        #For each board status table data, receive update
        $('td[class="boards"]').each (index,status) ->
            id_val = $(status).attr('id')
            $(status).html(message.data.board_status[id_val])
            #if($(status).html() is "Available")
            #$(status).parent().collapse("hide")
            #else
            $(status).parent().collapse("show")
            status_for_bitfile = ["Loading Kernel", "Ready to Use"]
            num = id_val.split('board')[1]
            user_id = '#' + 'user' + num
            $(user_id).html(message.data.board_status['user'+num])
            bit_id = '#' + 'bitf' + num
            #Recieve bitfile updates only after programming bitfile
            if(status_for_bitfile.indexOf($(status).html()) >= 0)
                $(bit_id).html(message.data.board_status['bitf' + num])
            else
                $(bit_id).html("")
            status_for_kernel = "Ready to Use"
            kern_id = '#' + 'kern' + num
            #Receive kernel updates only after programming Kernel
            if($(status).html() is status_for_kernel)
                $(kern_id).html(message.data.board_status['kern'+num])
            else
                $(kern_id).html("")       
                      
                         
        #For each board get a countdown timer to unlock
        tmp = {}
        $('td[class="locks"]').each (index,lock) ->
            id_val = $(lock).attr('id')
            num = id_val.split('lock')[1]
            board_id = '#'+'board' + num
            if($(lock).prev().html() != "")
                tmp[board_id] = $(lock).prev().prev().html()
            user_id = '#' +'user'+ num
            if $(board_id).html() is "Ready to Use"
                $(lock).html(message.data.board_status[id_val])
                if $('.userval').html() is $(user_id).html() or $('.userval').html() is 'Rakesh.Vasudevan@imgtec.com'
                    $(lock).prev().prev().html(tmp[board_id])
                    $(lock).next().removeClass('hidden')
                    $(lock).next().next().addClass('hidden')
                    $(lock).next().next().prop('disabled', true)
                else
                    $(lock).prev().prev().html("")
                    $(lock).next().addClass('hidden')
                    $(lock).next().next().addClass('hidden')
            else
                $(lock).next().addClass('hidden')
                $(lock).next().next().addClass('hidden')
                $(lock).html("")
        return
        
    
    #On clicking release for a board send a request to unlock board
    $('.release').click ->
        tr_id = $(this).parent().parent().attr('id')
        console.log(tr_id)
        console.log(typeof tr_id)
        data_dict = {}
        rc = confirm("Are you sure you want to release the board (Pressing OK will release the board)")
        data_dict['board_free'] = tr_id.split('row')[1]
        data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
        if(rc == true)
            $.ajax 
                url:"/bmauto/release/"
                type: 'POST'
                dataType:'text'
                data:data_dict
                error:(jqXHR, textStatus,errorThrown)->
                    alert(textStatus+errorThrown)

                success:(data, textStatus, jqXHR)->
                    console.log('removed' + tr_id)
                    location.reload()
                    return
                contentType: 'application/x-www-form-urlencoded'
        return
    #On clicking reboot for a board send a request to unlock board
    $('.reboot').click ->
        tr_id = $(this).parent().parent().attr('id')
        console.log(tr_id)
        console.log(typeof tr_id)
        data_dict = {}
        rc = confirm("Are you sure you want to reboot the board (Pressing OK will reboot the board)")
        data_dict['board_reboot'] = tr_id.split('row')[1]
        data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
        if(rc == true)
            $.ajax 
                url:"/bmauto/reboot/"
                type: 'POST'
                dataType:'text'
                data:data_dict
                error:(jqXHR, textStatus,errorThrown)->
                    alert(textStatus+errorThrown)

                success:(data, textStatus, jqXHR)->
                    console.log('rebooting' + tr_id)
                    return
                contentType: 'application/x-www-form-urlencoded'
        return
    return