module BreadcrumbTrailHelper
  def render_crumbs(options={})
	  return nil if @crumbs.nil?

    defaults = {:type => :ol, :class => 'breadcrumbs', :separator => ' &raquo; '}
    options = defaults.merge(options)

    list_items = Array.new

    case options[:type]
      when :ol, :ul
        @crumbs[0..-2].each do |c|
          list_items << content_tag(:li, link_to(h(c[:label]), c[:link]), :class => c[:class]) if c[:link]
          list_items << content_tag(:li, h(c[:label]), :class => c[:class]) unless c[:link]
        end
        c = @crumbs.last
        list_items << content_tag(:li, h(c[:label]), :class => c[:class])
        content_tag options[:type], list_items, :class => options[:class]
      when :p
        @crumbs[0..-2].each do |c|
          list_items << link_to(h(c[:label]), c[:link], :class => c[:class]) if c[:link]
          list_items << h(c[:label]) unless c[:link]
        end
        c = @crumbs.last
        list_items << h(c[:label]) unless c[:link]
        content_tag :p, list_items.join(options[:separator]), :class => options[:class]
      else
    end
  end
end