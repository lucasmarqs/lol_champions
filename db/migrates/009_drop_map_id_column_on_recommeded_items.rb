Sequel.migration do
  change do
    alter_table :recommended_items do
      drop_column :map_id

      add_column :map, String
      add_index :map
    end
  end
end
