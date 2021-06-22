# Göqanmattimysql

Ayakkabından su içilir abim

- Kumarhane scriptlerinde %50 resmon tasarrufu mevcuttur.
- Scriptin adını değiştirirseniz göqan abim sizi si-



# USE / Kullanım

```
mysql.async.execute = exports.goqanabimattim.execute
mysql.async.fetchall = exports.goqanabimattim:execute
mysql.async.insert =  exports.goqanabimattim:execute
mysql.sync.fetchall = exports.goqanabimattim:executeSync
mysql.sync.fetchscalar = exports.goqanabimattim:scalarSync
mysql.async.fetchscalar = exports.goqanabimattim:scalarSync
mysql.sync.execute = exports.goqanabimattim:execute
mysql.async.execute = exports.goqanabimattim:execute
mysql.ready = exports.goqanabimattim:ready(function()


    exports("ready", function (callback)
        Citizen.CreateThread(function ()
            -- add some more error handling
            while GetResourceState('goqanabimattim') ~= 'started' do
                Citizen.Wait(0)
            end
            -- while not exports['mysql-async']:is_ready() do
            --     Citizen.Wait(0)
            -- end
            callback()
        end)
    end)
    
```
<img width="1804" height="1000" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://cdn.discordapp.com/attachments/856837932282150922/856983390209048656/unknown.png">

Amanın anında

# Credits : goqanabi
