
function k_getDistanceBetweenCoords(vec1, vec2)
    d = (vec1.x - vec2.x)*(vec1.x - vec2.x) + (vec1.y - vec2.y)*(vec1.y - vec2.y) + (vec1.z - vec2.z)*(vec1.z - vec2.z)
    return math.sqrt(d)
end

