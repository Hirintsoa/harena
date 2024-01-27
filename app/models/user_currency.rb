class UserCurrency < ApplicationRecord
  belongs_to :currency
  belongs_to :account
end
