class RenamePersonIdInRelationshipsToSponsorId < ActiveRecord::Migration
  def change
  	rename_column :relationships, :person_id, :sponsor_id
  end
end
