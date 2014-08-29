module GeniusRenderer
  extend self

  def render(markdown)
    backticks = BacktickCodeBlock.render_code_block(markdown.to_s)
    html = GitHub::Markdown.render_gfm(backticks)

    post_process(html)
  end

  private

  def post_process(html)
    doc = Nokogiri::HTML.fragment(html)
    doc.css('.highlight code span').each do |el|
      el['data-highlight-class'] = el['class']
    end

    doc.css('.highlight pre').each do |pre|
      if pre.matches?('.line-numbers')
        pre.remove
      else
        pre.ancestors('.highlight').first.children = pre
      end
    end

    doc.to_html
  end
end
