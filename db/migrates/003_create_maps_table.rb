Sequel.migration do
  up do
    create_table :maps do
      primary_key :id
      String :name,         null: false
      String :full_image
      Integer :riot_id,     null: false, unique: true

      # Timestamps
      DateTime :created_at,  null: false
      DateTime :updated_at , null: false
    end
  end

  down do
    drop_table :maps
  end
end
