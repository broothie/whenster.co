module HasRole
  extend ActiveSupport::Concern

  included do
    str_enum :role, %i[guest host]
  end
end
