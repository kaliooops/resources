function server_distance_between_coords(x1, y1, z1, x2, y2, z2)
    local xd = x1 - x2
    local yd = y1 - y2
    local zd = z1 - z2

    return math.sqrt(xd * xd + yd * yd + zd * zd)
end