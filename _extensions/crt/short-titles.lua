--[[
      Pandoc Lua Filter to handle headings with toc-title and head-title
      key attributes
]]

-- if FORMAT ~= "latex" or
--     PANDOC_WRITER_OPTIONS.top_level_division ~= "top-level-chapter" or
--     PANDOC_VERSION < { 2, 17, 0 } then
--     return
-- end

traverse = 'topdown'

-- this part where we check for memoir class doesn't work as desired
isMemoir = false
function Meta(m)
    local documentclass = pandoc.utils.stringify(m['documentclass'])
    if documentclass == 'memoir' then
        isMemoir = true
    end
end

function Header(h)
    local divisions =
    {
        [0] = "\\chapter[",
        [1] = "\\section[",
        [2] = "\\subsection[",
        [3] = "\\subsubsection[",
        [4] = "\\paragraph[",
        [5] = "\\subparagraph["
    }

    -- match to current heading level
    if (divisions[h.level]) then
        -- both toc-title and head-title are defined
        if (h.attributes["toc-title"] and h.attributes["head-title"]) then
            h = pandoc.RawBlock("latex", divisions[h.level] ..
                h.attributes["toc-title"] .. "][" ..
                h.attributes["head-title"] .. "]{" ..
                pandoc.utils.stringify(h.content) .. "}")
            -- if only one is defined, set as toc-title
        elseif (h.attributes["toc-title"] or h.attributes["head-title"]) then
            h = pandoc.RawBlock("latex", divisions[h.level] ..
                (h.attributes["toc-title"] or h.attributes["head-title"]) .. "]{" ..
                pandoc.utils.stringify(h.content) .. "}")
        end
    end
    return h
end
