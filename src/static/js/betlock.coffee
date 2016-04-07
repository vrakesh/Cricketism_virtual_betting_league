$(document).ready ->
    #When swampdragon is ready subscribe to the board info channel
    swampdragon.ready ->
        swampdragon.subscribe 'match', 'matchinfo', null
        return
    #get channel message
    swampdragon.onChannelMessage (channels, message) ->
        match_status =  message.data.match_status
        console.log(" for each loop call")
        $('tr.matchrows').each ->
            console.log("inside each loop")
            match_id = $(this).attr('id')
            $(this).removeClass("success")
            $(this).removeClass('danger')
            $(this).removeClass('info')
            $(this).addClass(match_status['color'+match_id])
            $(this).find('#'+'time_left'+match_id).html(match_status['time_left'+match_id])
            $(this).find('#'+'odds'+match_id).html(match_status['odds'+match_id])

            mno = $(this).find('.storedbet').attr('id')
            $('#'+mno).html(match_status[mno])
            if  $(this).hasClass('info') or $(this).hasClass('danger')
                $(this).find('select').prop('disabled', 'disabled')

        return        
    dangerrows = $('.ttbody').find('.danger')
    if dangerrows.length > 0 
        for row in dangerrows
            $(row).find('select').prop('disabled', 'disabled')
    donerows = $('.ttbody').find('.info')
    if donerows.length > 0 
        for row in donerows
            $(row).find('select').prop('disabled', 'disabled')
    sel = $('input').filter('.stored')
    for selected in sel
        value = '#'+$(selected).val()
        opt = $('option').filter(value)
        $(opt).attr('selected','selected')
    
    ###
    On Clicking the button generate AJAX request to save to db
    ###
    $('.matchoption').change ->
        $('.matchoption').prop('disabled', true)
        data_dict = {}
        data_dict[$(this).parent().parent().attr('id')] = $(this).find(':selected').text()
        data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
        $.ajax 
            url:"/bet/update/"+$(this).parent().parent().attr('id')+'/'
            type: 'POST'
            dataType:'text'
            data:data_dict
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
            success:(data, textStatus, jqXHR)->
                #$('#error').html(data)
                $('.matchoption').prop('disabled',null)
                $('.matchoption').removeAttr('disabled')
                if data.indexOf('Error') > -1
                    alert(data)
                console.log('done here')
                true
            contentType: 'application/x-www-form-urlencoded'
        true
    ###
    On Clicking the home win button generate AJAX request to save to score to db
    ###
    $('.homewin').click ->
        name = $(this).attr('name')
        $('this').prop('disabled', true)
        $('this').next().prop('disabled', true)
        data_dict = {}
        data_dict['match'] = name
        data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
        console.log(data_dict)
        $.ajax 
            url:"/bet/score/update/"
            type: 'POST'
            dataType:'text'
            data:data_dict
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
            success:(data, textStatus, jqXHR)->
                #$('#error').html(data)
                $(this).prop('disabled',null)
                $(this).removeAttr('disabled')
                alert(data)
                console.log('done here')
                location.reload()
                true
            contentType: 'application/x-www-form-urlencoded'
        true
    ###
    On Clicking the home win button generate AJAX request to save to score to db
    ###
    $('.awaywin').click ->
        name = $(this).attr('name')
        $('this').prop('disabled', true)
        $('this').prev().prop('disabled', true)
        data_dict = {}
        data_dict['match'] = name
        data_dict['csrfmiddlewaretoken'] = $('input[name=csrfmiddlewaretoken]').val()
        console.log(data_dict)
        $.ajax 
            url:"/bet/score/update/"
            type: 'POST'
            dataType:'text'
            data:data_dict
            error:(jqXHR, textStatus,errorThrown)->
                alert(textStatus+errorThrown)
            success:(data, textStatus, jqXHR)->
                #$('#error').html(data)
                $(this).prop('disabled',null)
                $(this).removeAttr('disabled')
                alert(data)
                console.log('done here')
                location.reload()
                true
            contentType: 'application/x-www-form-urlencoded'
        true
    true