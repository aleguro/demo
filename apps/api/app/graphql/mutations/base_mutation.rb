module Mutations
  class BaseMutation < GraphQL::Schema::Mutation

  	def caller
			self.class.to_s.split("::").last.camelize(:lower)
		end

    def sanitize(payload)

			payload.keys.each do |key|

				if payload[key].is_a? Array

					arr = []
					payload[key].each do |elem|

						if elem.is_a? Types::BaseInputObject

						 	arr << sanitize(elem.to_kwargs)
						else
							arr << sanitize(elem)
						end 	
					end
					payload[key] = arr
				elsif payload[key].is_a? Hash

					payload[key] = sanitize(payload[key])
				elsif payload[key].is_a? Types::BaseInputObject

					payload[key] = sanitize(payload[key].to_kwargs)
				elsif payload[key].is_a? ApplicationRecord
					payload[key] = { type: payload[key].class.name, id: payload[key].id }
				elsif payload[key].is_a? ActiveRecord::Relation
					payload[key] = { type: payload[key]&.first&.class&.name, id: payload[key]&.length }
				end
			end		

			payload
		end
  end
end
