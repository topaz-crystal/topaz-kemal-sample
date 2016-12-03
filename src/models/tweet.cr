require "topaz"

class Tweet < Topaz::Model
  columns(
    {name: content, type: String},
    {name: likes,   type: Int64}
  )
end
