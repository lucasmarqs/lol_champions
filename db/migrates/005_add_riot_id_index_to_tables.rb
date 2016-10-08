Sequel.migration do
  change do
    alter_table :champions do
      add_index :riot_id
    end

    alter_table :maps do
      add_index :riot_id
    end

    alter_table :items do
      add_index :riot_id
    end
  end
end
