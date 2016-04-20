class Cuba
  def [](key)
    env['rack.session'][key]
  end
  def []=(key, value)
    env['rack.session'][key] = value
  end
end
