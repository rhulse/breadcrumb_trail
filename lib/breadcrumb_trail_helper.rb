module BreadcrumbTrailHelper
  def render_crumbs(options={})
	  return nil if @crumbs.nil?

    defaults = {:type => :ol, :class => 'breadcrumbs', :separator => ' &raquo; '}
    options = defaults.merge(options)

    list_items = Array.new

    case options[:type]
      when :ol, :ul
        @crumbs[0..-2].each do |c|
          list_items << generate_crumb(c, :li)
        end
        list_items << generate_last_crumb(@crumbs.last, :li)
        content_tag options[:type], list_items, :class => options[:class]

      when :p
        @crumbs[0..-2].each do |c|
          list_items << generate_crumb(c)
        end
        list_items << generate_last_crumb(@crumbs.last)
        content_tag :p, list_items.join(options[:separator]), :class => options[:class]
    end
  end

  def generate_crumb(c, type=nil)
    crumb = ''
    if c[:link]
      crumb = link_to(h(c[:label]), c[:link])
    else
      crumb = h(c[:label])
    end

    if type
      content_tag(type, crumb, :class => c[:class] )
    else
      crumb
    end
  end

  def generate_last_crumb(c, type=nil)
    c.delete(:link)
    generate_crumb(c, type)
  end
end
