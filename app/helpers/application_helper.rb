module ApplicationHelper
  def markdown_to_html(markdown_text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @markdown.render(markdown_text)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to name, '#', onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\"); return false;", class: :'btn btn-default btn-sm'
  end
end
