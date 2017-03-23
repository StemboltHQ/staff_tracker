class ActionView::Helpers::FormBuilder
  def error_message_for(field_name)
    if self.object.errors[field_name].present?
      model_name              = self.object.class.name.downcase
      target_elem_id          = "#{model_name}_#{field_name}"

      "<div class=\"inline-form-error\" for=\"#{target_elem_id}\">"\
      "#{self.object.errors[field_name].join(', ')}"\
      "</div>".html_safe
    end
  rescue
    nil
  end
end
