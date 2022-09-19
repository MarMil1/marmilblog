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
    
    def active_class_desktop?(*paths)
      active = false
      paths.each { |path| active ||= current_page?(path) }
      active ? 'current-link-btn-desktop' : nil
    end

    def active_class_mobile?(*paths)
      active = false
      paths.each { |path| active ||= current_page?(path) }
      active ? 'current-link-btn-mobile' : nil
    end

end
