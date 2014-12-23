module ApplicationHelper
  def flashes!
    return "" if flash.empty?
    
    messages = flash.map { |name, msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="errors">
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
  def attribute_table_row(name, value, clipboard_text = value)
    html = <<-HTML
    <tr>
      <td>#{name}</td>
      <td>#{value}</td>
      <td>
        #{
          content_tag(
            :a,
            t("myplaceonline.general.clipboard"),
            href: "#",
            class: "ui-btn ui-icon-action ui-btn-icon-notext nomargin clipboardable externallink",
            title: t("myplaceonline.general.clipboard"),
            data: { "clipboard-text" => clipboard_text }
          )
        }
      </td>
    </tr>
    HTML
    
    html.html_safe
  end
  
  def url_or_blank(url, text = nil, clipboard = nil)
    if !url.to_s.empty?
      if text.to_s.empty?
        text = url
      end
      
      options = Hash.new
      options[:href] = url
      options[:class] = "externallink"
      options[:target] = "_blank"
      if !clipboard.nil?
        options[:class] += " clipboardable"
        options["data-clipboard-text"] = clipboard
      end
      
      content_tag(
        :a,
        text,
        options
      )
    else
      "&nbsp;"
    end
  end
end
