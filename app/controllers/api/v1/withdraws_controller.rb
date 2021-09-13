class Api::V1::WithdrawsController < ApplicationController

	def withdraw_amount
		rem_amount = nil
		withdraw_amount = params[:input_amount].to_i
		amount = {}
		unless withdraw_amount == 0 || withdraw_amount < 0
	 		if withdraw_amount >= 25
		 		calulate_amount_quater(withdraw_amount)
		 	elsif withdraw_amount >= 10
				calulate_amount(withdraw_amount)
			elsif withdraw_amount >= 5
				if withdraw_amount >= 5
					calulate_amount_second(withdraw_amount)
				elsif rem_amount < 5 
					@penny = rem_amount
				end
			else
				calculate_amount_penny(withdraw_amount)
		 	end

		 	amount.merge!({quarter: (@quarter.nil? ? 0 : @quarter),dime: (@dime.nil? ? 0 : @dime) , nickel: (@nickel.nil? ?  0 : @nickel), penny: (@penny.nil? ? 0 : @penny) })
			
			render json: {amount: amount}
		else
			render json: {}, status: 400
		end
	end

	def calculate_amount_penny(withdraw_amount)
		@penny = withdraw_amount/5
		rem_amount = withdraw_amount%5
		if rem_amount < 5 
			@penny = rem_amount
		end
	end

	def calulate_amount_quater(withdraw_amount)
		@quarter = withdraw_amount/25
		rem_amount = withdraw_amount%25
		if rem_amount >= 10
			calulate_amount(rem_amount)
 		elsif rem_amount >= 5
				calulate_amount_second(rem_amount)
 		elsif rem_amount < 5
 			@penny = rem_amount
 		end
	end

	def calulate_amount(rem_amount)
		@dime = rem_amount/10
		rem_amount = rem_amount%10
		if rem_amount >= 5
			@nickel = rem_amount/5
			rem_amount = rem_amount%5
			if rem_amount < 5 
				@penny = rem_amount
			end
		else
			@penny = rem_amount
		end
	end

	def calulate_amount_second(rem_amount)
 		@nickel = rem_amount/5
		rem_amount = rem_amount%5
		if rem_amount < 5 
			@penny = rem_amount
		end
	end
end
