local translationEnabled = true

local function TranslateMessage(msg, author)
    if not translationEnabled then
        return msg
    end

    -- Split the message into individual words.
    local words = {}
    for word in msg:gmatch("%S+") do
        table.insert(words, word)
    end

    -- Determine which dictionary to use based on the language of the first word.
    local dictionary
    if ChatTranslateDictionaryRUtoEN[words[1]:lower()] then
        dictionary = ChatTranslateDictionaryRUtoEN
    elseif ChatTranslateDictionaryENtoRU[words[1]:lower()] then
        dictionary = ChatTranslateDictionaryENtoRU
    else
        -- If the first word is not in either dictionary, return the original message.
        return msg
    end

    -- Translate each word in the message.
    for i, word in ipairs(words) do
        local translated = dictionary[word:lower()]
        if translated then
            words[i] = translated
        end
    end

    -- Reconstruct the translated message.
    local translatedMsg = table.concat(words, " ")

    -- Print the translated message to the chat frame.
    DEFAULT_CHAT_FRAME:AddMessage(author .. ": " .. translatedMsg)
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_CHANNEL")
f:SetScript("OnEvent", function(self, event, msg, author)
    TranslateMessage(msg, author)
end)

-- Slash command handler
SLASH_TWTRANS1 = "/twtrans"
SlashCmdList["TWTRANS"] = function(msg)
    local command = string.lower(msg)
    if command == "on" then
        translationEnabled = true
        DEFAULT_CHAT_FRAME:AddMessage("twTrans: Translation enabled")
    elseif command == "off" then
        translationEnabled = false
        DEFAULT_CHAT_FRAME:AddMessage("twTrans: Translation disabled")
    else
        DEFAULT_CHAT_FRAME:AddMessage("twTrans: Unknown command. Use /twtrans on or /twtrans off.")
    end
end
