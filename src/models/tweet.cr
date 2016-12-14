require "topaz"

class Tweet < Topaz::Model
  columns(
    content: String,
    likes:   Int64
  )
end
