#!/usr/bin/env lua

--Pour utiliser : ./truc variable1=valeur1 variable2=valeur2 <entrée >sortie
--permet de remplacer ${variable1} par "valeur1" dans une chaîne de caractère
--peut aussi s'utiliser ainsi : % lua test.lua "un cochon=un chat" <<<'Oh ! ${un cochon} !' 
--Oh ! un chat !

function replace(file, table)
  local s = file:read("*a")
  return s:gsub("$(%b{})", function(s)
    return table[s:sub(2,-2)]
  end)
end

function parseargs(...)
  local out = {}
  for _, v in ipairs({...}) do
    local key = v:match("(.-)=")
    local val = v:match("=(.*)")
    out[key] = val
  end
  return out
end

io.write((replace(io.stdin, parseargs(...))))
