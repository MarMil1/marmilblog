module ApplicationHelper
    def markdown(text, options = {})
        options.reverse_merge!(
          :hard_wrap => true,
          :filter_html => true,
          :autolink => true,
          :no_intraemphasis => true,
          :fenced_code => true,
          :gh_blockcode => true,
          :strikethrough => true,
          :underline => true,
          :quote => true,
          :highlight => true,
          :prettify => true,
        )
        options.reject! { |k, v| !v }
        Markdown.new(text, *options.keys).to_html.html_safe
    end
    
end
