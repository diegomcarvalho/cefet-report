function Meta(meta)
    if meta["classoption"] then
        for _, opt in ipairs(meta["classoption"]) do
            local val = pandoc.utils.stringify(opt)
            if val == "twocolumn" then
                meta["is-twocolumn"] = true
                break
            end
        end
    end
    return meta
end
