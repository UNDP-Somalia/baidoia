require_dependency Rails.root.join("app", "models", "user").to_s

class User
  GENDER = %w[male female].freeze
  EDUCATION_LEVEL = %w[
    non
    primary_elementary
    preparatory
    secondary
    bachelor
    diploma
    masters
    phd
  ].freeze

  VILLAGE = %w[
    isha
    darusalam
    horseed
    berdale
    howl_wadaag
    wadajir
    weberi
    salamey
    towfiiq
    adaado
  ].freeze

  validates :gender, inclusion: { in: GENDER }, allow_blank: true
  validates :last_education_degree, inclusion: { in: EDUCATION_LEVEL }, allow_blank: true
  validates :village, inclusion: { in: VILLAGE }, allow_blank: true
end