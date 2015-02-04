class CreateJobposts < ActiveRecord::Migration
  def change
    create_table :jobposts do |t|
      t.references :tpo, index: true
      t.string :company_name
      t.string :position_offered
      t.string :required_percentage
      t.string :required_branch
      t.text :other_requirements
      t.text :job_profile
      t.string :venue
      t.string :state

      t.timestamps null: false
    end
    add_index :jobposts, [:tpo_id, :created_at]
  end
end
