module ConferencesHelper

  def event_status_options
    Event::STATUS.map{ |s| [ t(s, :scope => "event.status") ,s] }
  end

  def event_link(event)
    content_tag(:div,
      link_to(event.name, conference_path(event)) +
      tag(:br) +
      event.description,
    :class => "user")
  end

end
