class Admin::Widget::Cards::RowComponent < ApplicationComponent
  attr_reader :card, :header_section, :options
  alias_method :header_section?, :header_section

  def initialize(card, header_section, **options)
    @card = card
    @header_section = header_section
    @options = options
  end
end
