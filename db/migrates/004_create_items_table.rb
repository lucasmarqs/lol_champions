Sequel.migration do
  up do
    create_table :items do
      primary_key :id
      String :name,         null: false
      String :description,  null: false, text: true
      String :full_image
      Integer :riot_id,     null: false, unique: true

      # Timestamps
      DateTime :created_at,  null: false
      DateTime :updated_at , null: false
    end
  end

  down do
    drop_table :items
  end
end
