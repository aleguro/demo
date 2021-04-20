module Domain
	class Order
		include ActiveModel::Model

		attr_accessor :title, :body, :items

		validate 	:title, :body

		def to_h
			{title: self.title, body: self.body, items: self.items}
		end		
	end
end	