module ApplicationHelper
  def render_error_message(obj)
    render('shared/error_messages', object: obj) if obj.errors.any?
  end
end
