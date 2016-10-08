Sequel.migration do
  up do
    create_table :recommended_items do
      primary_key :id
      foreign_key :champion_id, :champions, on_delete: :cascade
      foreign_key :item_id,     :items,     on_delete: :cascade
      foreign_key :map_id,      :maps,      on_delete: :cascade

      # Timestamps
      DateTime :created_at,  null: false
      DateTime :updated_at , null: false

      unique [:champion_id, :item_id, :map_id]
    end
  end

  down do
    drop_table :recommended_items
  end
end
