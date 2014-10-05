class CreateSunlightBills < ActiveRecord::Migration
  def change
    create_table :sunlight_bills do |t|
      t.string :bill_id
      t.string :bill_type
      t.string :chamber
      t.integer :congress_num
      t.integer :cosponsors_count
      t.integer :enacted_as_congress_num
      t.string :enacted_as_law_type
      t.string :enacted_as_law_num
      t.date :introduced_on
      t.date :last_version_on
      t.text :official_title
      t.text :popular_title
      t.text :short_title
      t.string :sponsor_id
    end
  end
end
