module Curupira::AuthorizeHelper
  def link_to_authorize(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    method = html_options["data-method"].to_s.upcase if html_options["data-method"]

    request_data = Rails.application.routes.recognize_path(url, method: method)

    if has_authorization_for(request_data)
      html_options['href'] ||= url
    else
      html_options['style'] = "cursor: not-allowed;"
      html_options['class'] = "#{html_options['class']} not-allowed";
    end

    content_tag(:a, name || url, html_options, &block)
  end
end