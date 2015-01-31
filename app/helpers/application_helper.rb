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
  
  def is_blank(value, strip = true)
    if strip && value.is_a?(String) && !value.nil?
      value = value.strip
    end
    value.nil? ||
      (value.is_a?(String) &&
        (value.length == 0 || value == "&nbsp;"))
  end
  
  def attribute_table_row(name, value, clipboard_text = value, valueclass = nil)
    if is_blank(value)
      return nil
    end
    valueclass ||= ""
    html = <<-HTML
    <tr>
      <td>#{name}</td>
      <td class="#{valueclass}">#{value}</td>
      <td style="padding: 0.2em; vertical-align: top;">
        #{
          !is_blank(clipboard_text.to_s) ?
            content_tag(
              :a,
              t("myplaceonline.general.clipboard"),
              href: "#",
              class: "ui-btn ui-icon-action ui-btn-icon-notext nomargin clipboardable externallink",
              title: t("myplaceonline.general.clipboard"),
              data: { "clipboard-text" => html_escape("" + clipboard_text.to_s) }
            )
            : "&nbsp;"
        }
      </td>
    </tr>
    HTML
    
    html.html_safe
  end
  
  def attribute_table_row_url(name, url, may_be_nonurl = false, url_text = nil, clipboard = nil, linkclasses = nil, external = false)
    if may_be_nonurl && !url.blank? && !url.start_with?("/") && !url.start_with?("http:")
      # Probably not a URL, just display raw text
      attribute_table_row(name, url)
    else
      attribute_table_row(name, url_or_blank(url, url_text, clipboard, linkclasses, external), url, nil)
    end
  end
  
  def attribute_table_row_email(name, email)
    if !email.blank? && email.include?("@")
      attribute_table_row(name, url_or_blank("mailto:" + email, email), email)
    else
      attribute_table_row(name, email)
    end
  end
  
  def attribute_table_row_markdown(name, markdown)
    attribute_table_row(name, Myp.markdown_to_html(markdown), markdown, "markdowncell")
  end
  
  def attribute_table_row_boolean(name, val)
    attribute_table_row(name, val ? t("myplaceonline.general.yes") : t("myplaceonline.general.no"))
  end

  def attribute_table_row_reference(name, pathfunc, ref)
    val = ref.nil? ? nil : url_or_blank(send(pathfunc, ref), ref.display)
    attribute_table_row(name, val)
  end
  
  def url_or_blank(url, text = nil, clipboard = nil, linkclasses = nil, external = false)
    if !url.to_s.empty?
      if text.to_s.empty?
        text = url
      end
      
      options = Hash.new
      options[:href] = url
      options[:class] = ""
      
      # If it's probably external
      if external || (!url.start_with?("/") || url.start_with?("//"))
        options[:class] += " externallink"
        options[:target] = "_blank"
        options["data-ajax"] = "false"
      end
      if !clipboard.nil?
        options[:class] += " clipboardable"
        options["data-clipboard-text"] = html_escape("" + clipboard.to_s)
      end
      if !linkclasses.blank?
        options[:class] += " " + linkclasses
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
  
  def myp_label_classes(value)
    is_blank(value, false) ? "ui-hidden-accessible" : "form_field_label"
  end
  
  def myp_field_classes(autofocus, input_classes)
    result = autofocus ? "autofocus" : ""
    if !input_classes.nil? && input_classes.length > 0
      if result.length > 0
        result += " "
      end
      result += input_classes
    end
    result
  end
  
  def myp_text_field(form, name, placeholder, value, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      form.label(name, placeholder, class: myp_label_classes(value)) +
      form.text_field(name, placeholder: placeholder, class: myp_field_classes(autofocus, input_classes), value: value)
    ).html_safe
  end
  
  def myp_number_field(form, name, placeholder, value, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      form.label(name, placeholder, class: myp_label_classes(value)) +
      form.number_field(name, placeholder: placeholder, class: myp_field_classes(autofocus, input_classes), value: value)
    ).html_safe
  end
  
  def myp_text_field_tag(name, placeholder, value, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      label_tag(name, placeholder, class: myp_label_classes(value)) +
      text_field_tag(name, value, placeholder: placeholder, class: myp_field_classes(autofocus, input_classes))
    ).html_safe
  end
  
  def myp_date_field(form, name, placeholder, value, autofocus = false, input_classes = nil)
    # http://dev.jtsage.com/jQM-DateBox/doc/3-0-first-datebox/
    # Options should match app/assets/javascripts/myplaceonline_final.js form_add_item
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      form.label(name, placeholder, class: myp_label_classes(value)) +
      form.date_field(
        name,
        placeholder: placeholder,
        class: myp_field_classes(autofocus, input_classes),
        value: value,
        "data-role" => "datebox",
        "data-datebox-mode" => "datebox",
        "data-datebox-override-date-format" => "%Y-%m-%d",
        "data-datebox-use-focus" => "true",
        "data-datebox-use-clear-button" => "true",
        "data-datebox-use-modal" => "false"
      )
    ).html_safe
  end

  def myp_file_field(form, name, placeholder, value, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      form.label(name, placeholder, class: myp_label_classes(value)) +
      form.file_field(name, placeholder: placeholder, class: myp_field_classes(autofocus, input_classes), value: value)
    ).html_safe
  end
  
  def is_probably_i18n(str)
    !str.nil? && str.include?("myplaceonline.")
  end

  def myp_text_area(form, name, placeholder, value, autofocus = false, input_classes = nil)
    # No need to set 'rows' or height because of autogrow:
    # https://github.com/jquery/jquery-mobile/blob/master/js/widgets/forms/autogrow.js
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      form.label(name, placeholder, class: myp_label_classes(value)) +
      form.text_area(name, placeholder: placeholder, class: myp_field_classes(autofocus, input_classes), value: value)
    ).html_safe
  end

  def myp_text_area_markdown(form, name, placeholder, value, autofocus = false, input_classes = nil)
    myp_text_area(form, name, I18n.t(placeholder) + " (" + I18n.t("myplaceonline.general.supports_markdown") + ")", value, autofocus, input_classes)
  end

  def myp_check_box(form, name, placeholder, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      form.check_box(name, class: myp_field_classes(autofocus, input_classes)) +
      form.label(name, placeholder)
    ).html_safe
  end
  
  def myp_check_box_tag(name, placeholder, checked, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    content_tag(
      :p,
      check_box_tag(name, true, checked, class: myp_field_classes(autofocus, input_classes)) +
      label_tag(name, placeholder)
    ).html_safe
  end
  
  def default_region
    "US"
  end

  def myp_region_field(form, name, placeholder, value, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    if input_classes.nil?
      input_classes = ""
    else
      input_classes += " "
    end
    input_classes += "region"
    content_tag(
      :p,
      form.label(name, placeholder, class: "ui-hidden-accessible") +
      form.select(name, region_options_for_select(Carmen::Country.all, value, priority: [default_region]), {}, { :class => myp_field_classes(autofocus, input_classes) })
    ).html_safe
  end
  
  def myp_subregion_field(form, name, placeholder, regionvalue, subregionvalue)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    render(partial: 'myplaceonline/subregionselect', locals: { f: form, regionstr: regionvalue, subregion: subregionvalue })
  end

  def myp_subregion_select_field(form, name, placeholder, region, subregionvalue, autofocus = false, input_classes = nil)
    if is_probably_i18n(placeholder)
      placeholder = I18n.t(placeholder)
    end
    coded_region = Carmen::Country.coded(region.code)
    options = coded_region.subregions.map { |r| [r.name, r.code] }
    options.sort!{|a, b| a.first.to_s <=> b.first.to_s}
    content_tag(
      :p,
      form.label(name, placeholder, class: myp_label_classes(subregionvalue)) +
      form.select(name, options_for_select(options, subregionvalue), class: myp_field_classes(autofocus, input_classes), prompt: placeholder)
    ).html_safe
  end
end
