function Div (div)
    -- First, check if we have the custom-style attribute
    if not div.attributes['custom-style'] then
        return div
    end

    -- Check if div has content
    if not div.content or #div.content == 0 then
        return div
    end

    -- Get the first element
    local first_elem = div.content[1]
    
    -- Check if it's a table
    if first_elem and first_elem.t == 'Table' then
        -- Copy the custom-style attribute to the table
        if not first_elem.attributes then
            first_elem.attributes = {}
        end
        first_elem.attributes['custom-style'] = div.attributes['custom-style']
        return first_elem
    end

    -- If we get here, return the original div
    return div
end
