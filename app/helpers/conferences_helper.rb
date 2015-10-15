module ConferencesHelper

  def event_link(event)
    content_tag(:div,
      link_to(event.name, conference_path(event)) +
      tag(:br) + 
      event.description,
    :class => "user")
  end

end
