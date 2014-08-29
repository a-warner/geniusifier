# https://github.com/imathis/octopress/blob/73e540409ceb8bc18048b6a96a4b815fc303ea28/plugins/backtick_code_block.rb
module BacktickCodeBlock
  AllOptions = /([^\s]+)\s+(.+?)\s+(https?:\/\/\S+|\/\S+)\s*(.+)?/i
  LangCaption = /([^\s]+)\s*(.+)?/i
  def self.render_code_block(input)
    @options = nil
    @caption = nil
    @lang = nil
    @url = nil
    @title = nil
    input.gsub(/^`{3} *([^\n]+)?\n(.+?)\n`{3}/m) do
      @options = $1 || ''
      str = $2

      if @options =~ AllOptions
        @lang = $1
        @caption = "<figcaption><span>#{$2}</span><a href='#{$3}'>#{$4 || 'link'}</a></figcaption>"
      elsif @options =~ LangCaption
        @lang = $1
        @caption = "<figcaption><span>#{$2}</span></figcaption>"
      end

      if str.match(/\A( {4}|\t)/)
        str = str.gsub(/^( {4}|\t)/, '')
      end
      if @lang.nil? || @lang == 'plain'
        code = HighlightCode::tableize_code(str.gsub('<','&lt;').gsub('>','&gt;'))
        "<figure class='code'>#{@caption}#{code}</figure>"
      else
        if @lang.include? "-raw"
          raw = "``` #{@options.sub('-raw', '')}\n"
          raw += str
          raw += "\n```\n"
        else
          code = HighlightCode::highlight(str, @lang)
          "<figure class='code'>#{@caption}#{code}</figure>"
        end
      end
    end
  end
end
