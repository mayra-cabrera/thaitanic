Spree::Order.class_eval do

  checkout_flow do
    go_to_state :address
    go_to_state :delivery
    go_to_state :confirm
    go_to_state :payments
    go_to_state :complete
  end

  after_create :update_order_number

  def update_order_number
    number = self.id.to_s
    self.update_attribute_without_callbacks :number, number
  end

  def create_braintree_transaction(credit_card_information)
    Braintree::Transaction.sale(
      amount: self.total,
      credit_card: {
        number:           credit_card_information[:number],
        expiration_month: credit_card_information[:expiration_month],
        expiration_year:  credit_card_information[:expiration_year],
        cvv:              credit_card_information[:cvv],
        cardholder_name:  credit_card_information[:cardholder_name]
      },
      billing: {
        street_address:   self.bill_address.address1,
        extended_address: self.bill_address.address2,
        region:           self.bill_address.state.abbr,
        postal_code:      self.bill_address.zipcode,
        country_code_alpha2: self.bill_address.country.iso
      },
      options: { submit_for_settlement: true }
    )
  end
end