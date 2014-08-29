module GeniusRenderer
  extend self

  def render(markdown)
    GitHub::Markdown.render_gfm(BacktickCodeBlock.render_code_block(markdown.to_s))
  end
end
