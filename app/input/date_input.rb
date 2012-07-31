class DateInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge(:class => "ui-date-picker")
  end
end
