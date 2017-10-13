module ApplicationHelper
    def markdown(text)
        markdown = Redcarpet::Markdown.new(
            Redcarpet::Render::HTML.new(
                prettify: true,
                hard_wrap: true
                ),
            fenced_code_blocks: true,
            strikethrough: true,
            autolink: true,
            tables: true,
            underline: true,
            highlight: true,
            quote: true,
            footnote: true
            )
        markdown.render(text).html_safe
    end
    
end
