Command = { }

function Command.new(name, desc)
  local o = {
    name = name,
    description = desc,
  }
  return setmetatable(o, { __index = Command })
end

function Command:show()
  print(string.format('%s\t%s', self.name, self.description))
end

return Command
