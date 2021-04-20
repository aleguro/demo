class CreateOrderCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :order_commands do |t|

    	t.string :command_name, null: false
    	t.integer :order_id, null: true
    	t.jsonb :snapshot, null: true
    	t.jsonb :payload, null: true
      t.timestamps
    end

    add_index :order_commands, :order_id
    add_index :order_commands, :command_name    
  end
end
