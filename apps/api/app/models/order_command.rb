class OrderCommand < ApplicationRecord

	validates :command_name, presence: true
	after_save :fill_in_id

	def fill_in_id

		self.update_column(:order_id, self.id)
	end
end