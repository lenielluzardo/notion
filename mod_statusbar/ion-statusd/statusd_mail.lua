--
-- ion/ext_statusbar/ion-statusd/statusd_mail.lua
-- 
-- Copyright (c) Tuomo Valkonen 2004-2005.
--
-- Ion is free software; you can redistribute it and/or modify it under
-- the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
--

local defaults={
    update_interval=60*1000,
    mbox=os.getenv("MAIL")
}

local settings=table.join(statusd.get_config("mail"), defaults)

local function calcmail(fname)
    local f=io.open(fname, 'r')
    local total, read, old=0, 0, 0
    local had_blank=true
    local in_headers=false
    local had_status=false
    
    if not f then
        return 0, 0, 0
    end
    
    for l in f:lines() do
        if had_blank and string.find(l, '^From ') then
            total=total+1
            had_status=false
            in_headers=true
            had_blank=false
        else
            had_blank=false
            if l=="" then
                if in_headers then
                    in_headers=false
                end
                had_blank=true
            elseif in_headers and not had_status then
                local st, en, stat=string.find(l, '^Status:(.*)')
                if stat then
                    had_status=true
                    if string.find(l, 'R') then
                        read=read+1
                    end
                    if string.find(l, 'O') then
                        old=old+1
                    end
                end
            end
        end
    end
    
    f:close()
    
    return total, total-read, total-old
end

local mail_timer

local function update_mail()
    assert(settings.mbox)
    
    local mail_total, mail_unread, mail_new=calcmail(settings.mbox)
    
    statusd.inform("mail_new", tostring(mail_new))
    statusd.inform("mail_unread", tostring(mail_unread))
    statusd.inform("mail_total", tostring(mail_total))
    
    if mail_new>0 then
        statusd.inform("mail_new_hint", "important")
    else
        statusd.inform("mail_new_hint", "normal")
    end

    if mail_unread>0 then
        statusd.inform("mail_unread_hint", "important")
    else
        statusd.inform("mail_unread_hint", "normal")
    end

    mail_timer:set(settings.update_interval, update_mail)
end

-- Init
statusd.inform("mail_new_template", "00")
statusd.inform("mail_unread_template", "00")
statusd.inform("mail_total_template", "00")

mail_timer=statusd.create_timer()
update_mail()
