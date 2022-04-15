function YellowPagesGetPosts(a, b)
    exports.ghmattimysql:execute([===[
      SELECT yellowpages_posts.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon, vrp_users.firstName as firstname, vrp_users.secondName as lastname FROM yellowpages_posts LEFT JOIN twitter_accounts ON yellowpages_posts.authorId = twitter_accounts.id LEFT JOIN vrp_users ON yellowpages_posts.realUser = vrp_users.id ORDER BY time DESC LIMIT 30
      ]===], {}, b)
end
function YellowPagesPostIlan(a, b, c, d, e)
    getUserYellow(d, function(f)
        -- exports.ghmattimysql:execute("SELECT phone_number FROM users WHERE users.identifier = @realUser", {["@realUser"] = d}, function(g)
        --     exports.ghmattimysql:execute("INSERT INTO yellowpages_posts (`authorId`, `message`, `image`, `realUser`, `phone`) VALUES(@authorId, @message, @image, @realUser, @phone);", {["@authorId"] = f.id, ["@message"] = a, ["@image"] = b, ["@realUser"] = d, ["@phone"] = g[1].phone_number}, function(h)
        --         post = {}
        --         post["authorId"] = f.id;
        --         post["message"] = a;
        --         post["image"] = b;
        --         post["realUser"] = d;
        --         post["time"] = os.date()
        --         post["author"] = f.author;
        --         post["authorIcon"] = f.authorIcon;
                
        --         TriggerClientEvent("gcPhone:yellow_newPost", -1, post)
        --     end)
        -- end)
        exports.ghmattimysql:execute("SELECT phone_number FROM vrp_users WHERE vrp_users.id = @realUser", {
          ['@realUser'] = d
        }, function (g)
          exports.ghmattimysql:execute('INSERT INTO yellowpages_posts (`authorId`, `message`, `image, `realUser`, `phone`) VALUES(@authorId, @message, @image, @realUser, @phone);', {
            ['@authorId'] = f.id,
            ['@message'] = a,
            ['@image'] = b,
            ['@realUser'] = d,
            ['@phone'] = g[1].phone_number
          }, function (h)
            post = {}
            post['authorId'] = f.id;
            post['message'] = a;
            post['image'] = b;
            post['realUser'] = d;
            post['time'] = os.date()
            post['author'] = f.author;
            post['authorIcon'] = f.authorIcon;

            TriggerClientEvent('gcPhone:yellow_newPost', -1, post)
          end)
        end)

    end)
end

function YellowGetMyPosts(accountId, cb)
    exports.ghmattimysql:execute([===[
      SELECT yellowpages_posts.*,
        twitter_accounts.username as author,
        twitter_accounts.avatar_url as authorIcon
      FROM yellowpages_posts
        LEFT JOIN twitter_accounts
          ON twitter_accounts.identifier = @accountId
      WHERE realUser = @accountId ORDER BY TIME DESC LIMIT 30
    ]===]
        
        
        
        
        
        
        
        , {['@accountId'] = accountId}, cb)
end

function getUserYellow(identifier, cb)
    -- exports.ghmattimysql:execute("SELECT id, username as author, avatar_url as authorIcon FROM twitter_accounts WHERE twitter_accounts.identifier = @identifier", {
    --     ['@identifier'] = identifier
    -- }, function(data)
    --     cb(data[1])
    -- end)

    local data = exports.ghmattimysql:executeSync("SELECT id, username as author, avatar_url as authorIcon FROM twitter_accounts WHERE twitter_accounts.identifier = @identifier", {identifier = identifier})

    cb(data[1])
end

function YellowToogleDelete(identifier, id, sourcePlayer)
    exports.ghmattimysql:execute('DELETE FROM yellowpages_posts WHERE id = @id', {
        ['@id'] = id,
    }, function()
        YellowGetMyPosts(identifier, function(posts)
            TriggerClientEvent('gcPhone:yellow_getMyPosts', sourcePlayer, posts)
        end)
    end)
end

function TwitterShowError(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showError', sourcePlayer, message)
end

RegisterServerEvent('gcPhone:yellow_getPosts')
AddEventHandler('gcPhone:yellow_getPosts', function()
    local sourcePlayer = tonumber(source)
    YellowPagesGetPosts(nil, function(posts)
        TriggerClientEvent('gcPhone:yellow_getPosts', sourcePlayer, posts)
    end)
end)

RegisterServerEvent('gcPhone:yellow_getMyPosts')
AddEventHandler('gcPhone:yellow_getMyPosts', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    YellowGetMyPosts(srcIdentifier, function(posts)
        TriggerClientEvent('gcPhone:yellow_getMyPosts', sourcePlayer, posts)
    end)
end)

RegisterServerEvent('gcPhone:yellow_toggleDeletePost')
AddEventHandler('gcPhone:yellow_toggleDeletePost', function(id)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    YellowToogleDelete(srcIdentifier, id, sourcePlayer)
end)

RegisterServerEvent('gcPhone:yellow_postIlan')
AddEventHandler('gcPhone:yellow_postIlan', function(message, image)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    YellowPagesPostIlan(message, image, sourcePlayer, srcIdentifier)
end)