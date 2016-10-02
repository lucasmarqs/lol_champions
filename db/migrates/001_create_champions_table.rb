Sequel.migration do
  up do
    create_table :champions do
      primary_key :id
      String :name,         null: false
      String :title,        null: false
      String :lore,         text: true, null: false
      Integer :riot_id,     null: false, unique: true

      # Timestamps
      DateTime :created_at,  null: false
      DateTime :updated_at , null: false
    end
  end

  down do
    drop_table :champions
  end
end
