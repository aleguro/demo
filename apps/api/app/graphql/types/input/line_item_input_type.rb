module Types::Input
  class LineItemInputType < Types::BaseInputObject
 		argument :name, String, required: true
 		argument :cost, Float, required: true
 		argument :quantity, Integer, required: true
  end
end   	