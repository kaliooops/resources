RegisterServerCallback("gcPhone:getCrypto",function(a,b,c)
    local d=vRP.getUserId({a})
    if not d then 
        return 
    end;
   exports.ghmattimysql:execute("SELECT crypto FROM vrp_users WHERE id = @identifier",{["@identifier"]=d},function(e)
        b(json.decode(e[1].crypto)[c])
    end)
end)

RegisterServerEvent("gcPhone:buyCrypto")
AddEventHandler("gcPhone:buyCrypto",function(a,b,c,d)
    local e=vRP.getUserId({source})
    local f=Round(c)
    local proxysefu = vRP.getUserSource({e})
    if not e then
        return 
    end;
         local g={}
         exports.ghmattimysql:execute("SELECT crypto FROM vrp_users WHERE id = @identifier",{["@identifier"]=e},function(h)
            if f<0 then f=f*-1 
            end;
            g=json.decode(h[1].crypto)
            if a==1 then
                -- e = user id
                baniBank = vRP.getBankMoney({e})
                val = d*f
                if baniBank >= val then 
                    vRP.setBankMoney({e,baniBank-val})
                    g[b]=g[b]+f;
                    TriggerClientEvent("updateCrypto",proxysefu,b)
                else
                    TriggerClientEvent('okokNotify:Alert', proxysefu, "Eroare", "Nu ai destui bani ("..val.."$)!", 5000, 'error')
                end 
            elseif a==2 then
                baniBank = vRP.getBankMoney({e})
                suma = d*f
                if g[b]>=f then
                    vRP.setBankMoney({e, baniBank+suma})
                    g[b]=g[b]-f
                    TriggerClientEvent("updateCrypto",proxysefu,b)
                    TriggerClientEvent('okokNotify:Alert', proxysefu, 'Crypto Market', 'Ai vandut '..f..' monede si ai castigat '..suma..'$', 5000, 'success')
                else 
                    TriggerClientEvent('okokNotify:Alert', proxysefu, "Eroare", "Nu ai destule monede!", 5000, 'error')
                end 
            else print("phone coin error because SOB LilBecha"..e)
                return 
            end;
            exports.ghmattimysql:execute("UPDATE vrp_users SET crypto = @crypto WHERE id = @identifier",{["@identifier"]=e,["@crypto"]=json.encode(g)})
        end)
end)

function Round(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10^numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end    