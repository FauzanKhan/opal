class CreateEligibleBranches < ActiveRecord::Migration
  def change
    create_table :eligible_branches do |t|
	  t.belongs_to :jobpost
	  t.belongs_to :branch
    end
  end
end
