class Admin::Widget::Cards::TableComponent < ApplicationComponent
  attr_reader :cards, :header_section, :no_cards_message, :options
  alias_method :header_section?, :header_section

  def initialize(cards, header_section: false, no_cards_message:, **options)
    @cards = cards
    @header_section = header_section
    @no_cards_message = no_cards_message
    @options = options
  end

  private

    def attribute_name(attribute)
      ::Widget::Card.human_attribute_name(attribute)
    end
end
