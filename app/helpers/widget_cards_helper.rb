module WidgetCardsHelper
  def header?(card)
    card.header? || params[:controller] == "sdg_management/header"
  end
end
