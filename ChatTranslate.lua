local function TranslateChat(self, event, msg, author, ...)
    local words = {}
    for word in string.gmatch(msg, "%S+") do
        local translation = ChatTranslateDictionary[word]
        if translation then
            table.insert(words, translation)
        else
            table.insert(words, word)
        end
    end
    local newMsg = table.concat(words, " ")
    return false, newMsg, author, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", TranslateChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", TranslateChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", TranslateChat)