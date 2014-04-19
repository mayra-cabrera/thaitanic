Spree::CheckoutController.class_eval do
	before_filter :complete_order, only: :update

	def complete_order
		return unless @order.payments?
		result = @order.create_braintree_transaction(params[:credit_card_information])
		unless result.success?
      flash[:error] = result.errors.map(&:message).join(",")
      redirect_to checkout_state_path('payments') and return
		end
	end
	
	private

	def ensure_valid_state
    true
  end
end